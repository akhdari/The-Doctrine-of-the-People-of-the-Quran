import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/models/post/lecture.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/network/api_endpoints.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/management_buttons_menu.dart';
import 'dart:async';
import 'dart:developer' as dev;

import '../../dialogs/lecture.dart';
import '../../../../controllers/lecture.dart';
import '../../../../controllers/edit_lecture.dart';
import '../../error_illustration.dart';
import 'lecture.dart';
import '/system/widgets/three_bounce.dart';

class LectureShow extends StatefulWidget {
  final LectureController controller;

  const LectureShow({super.key, required this.controller});

  @override
  State<LectureShow> createState() => _LectureShowState();
}

class _LectureShowState extends State<LectureShow> {
  final Rxn<LectureForm> lecture = Rxn<LectureForm>();
  final Duration delay = const Duration(seconds: 5);
  late EditLecture editLectureController;
  final RxBool hasSelection = false.obs;

  void _loadData() {
    widget.controller.isLoading.value = true;

    Future.wait([
      Future.delayed(delay),
      widget.controller.getData(ApiEndpoints.getSpecialLectures),
    ]).then((_) {
      if (mounted) {
        widget.controller.isLoading.value = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();

    editLectureController = Get.isRegistered<EditLecture>()
        ? Get.find<EditLecture>()
        : Get.put(EditLecture(initialLecture: null, isEdit: false));
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(() => TopButtons(
                onAdd: () {
                  if (Get.isRegistered<EditLecture>()) {
                    hasSelection.value = false;
                    lecture.value = null;
                    Get.delete<EditLecture>();
                  }
                  Get.dialog(LectureDialog());
                },
                onEdit: () {
                  if (lecture.value != null) {
                    editLectureController.updateLecture(LectureForm(
                      lecture: lecture.value?.lecture,
                      teachers: lecture.value?.teachers ?? [],
                      schedules: lecture.value?.schedules ?? [],
                    ));
                    editLectureController.isEdit = true;
                    Get.dialog(LectureDialog());
                  }
                },
                onDelete: () async {
                  await widget.controller
                      .postDelete(lecture.value!.lecture.lectureId ?? 0);
                  lecture.value = null;
                  hasSelection.value = false;
                  _loadData();
                },
                hasSelection: hasSelection.value,
              )),
        ),
        Expanded(
          child: Obx(() {
            if (widget.controller.isLoading.value) {
              return const Center(child: ThreeBounce());
            }

            if (widget.controller.errorMessage.value.isNotEmpty) {
              return ErrorIllustration(
                illustrationPath: 'assets/illustration/bad-connection.svg',
                title: 'خطأ في الاتصال',
                message: widget.controller.errorMessage.value,
                onRetry: _loadData,
              );
            }

            if (widget.controller.lectureList.isEmpty) {
              return ErrorIllustration(
                illustrationPath: 'assets/illustration/empty-box.svg',
                title: 'لا توجد محاضرات',
                message:
                    'لا توجد محاضرات مسجلة حالياً. اضغط على زر الإضافة لإنشاء محاضرة جديدة.',
                onRetry: _loadData,
              );
            }

            return LectureGrid(
              data: widget.controller.lectureList,
              onRefresh: () {
                _loadData();
                return widget.controller.getData(ApiEndpoints.getLectures);
              },
              onDelete: (id) => widget.controller.postDelete(id),
              onTap: (details) {
                dev.log('تم الضغط على الصف: $details');
                hasSelection.value = details != null;
              },
              getObj: (obj) {
                if (obj != null) {
                  dev.log('المحاضرة المختارة: $obj');
                  lecture.value = obj;
                } else {
                  dev.log('تم إلغاء اختيار المحاضرة');
                  lecture.value = null;
                }
              },
            );
          }),
        ),
      ],
    );
  }
}

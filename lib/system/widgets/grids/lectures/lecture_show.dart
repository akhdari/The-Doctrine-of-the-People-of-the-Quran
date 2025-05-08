import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:developer' as dev;
import '../../dialogs/lecture.dart';
import '../../../../controllers/lecture.dart';
import '../../../../controllers/edit_lecture.dart';
import '../../../../controllers/form_controller.dart' as form;
import '../../error_illustration.dart';
import 'lecture.dart';
import '/system/widgets/three_bounce.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/models/get/lecture_class.dart';

class LectureShow extends StatefulWidget {
  final String fetchUrl;
  final String deleteUrl;
  final LectureController controller;

  const LectureShow({
    super.key,
    required this.fetchUrl,
    required this.deleteUrl,
    required this.controller,
  });

  @override
  State<LectureShow> createState() => _LectureShowState();
}

class _LectureShowState extends State<LectureShow> {
  final Rxn<Lecture> lecture = Rxn<Lecture>();
  final Duration delay = const Duration(seconds: 5);
  late EditLecture editLectureController;
  final RxBool hasSelection = false.obs;

  void _loadData() {
    widget.controller.isLoading.value = true;

    Future.wait([
      Future.delayed(delay),
      widget.controller.getData(widget.fetchUrl, onFinished: () {}),
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
    // Initialize EditLecture controller if not already registered
    if (!Get.isRegistered<EditLecture>()) {
      editLectureController = Get.put(EditLecture(
        initialLecture: Lecture(
          id: '',
          lectureNameAr: '',
          lectureNameEn: '',
          circleType: '',
          teacherIds: [],
          studentCount: 0,
        ),
        isEdit: false,
      ));
    } else {
      editLectureController = Get.find<EditLecture>();
    }
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.add, color: Colors.black),
                onPressed: () {
                  Get.dialog(LectureDialog());
                },
              ),
              Obx(() => IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: hasSelection.value ? Colors.black : Colors.grey,
                    ),
                    onPressed: hasSelection.value
                        ? () {
                            final currentLecture = lecture.value!;
                            Get.put(form.FormController(10));
                            editLectureController.updateLecture(currentLecture);
                            editLectureController.isEdit = true;
                            Get.dialog(LectureDialog());
                          }
                        : null,
                  )),
            ],
          ),
        ),
        Expanded(
          child: Obx(() {
            if (widget.controller.isLoading.value) {
              return Center(child: ThreeBounce());
            }

            if (widget.controller.errorMessage.value.isNotEmpty) {
              return ErrorIllustration(
                illustrationPath: 'assets/illustration/bad-connection.svg',
                title: 'Connection Error',
                message: widget.controller.errorMessage.value,
                onRetry: _loadData,
              );
            }

            if (widget.controller.lectureList.isEmpty) {
              return ErrorIllustration(
                illustrationPath: 'assets/illustration/empty-box.svg',
                title: 'No Lectures Found',
                message:
                    'There are no lectures registered yet. Click the add button to create one.',
                onRetry: _loadData,
              );
            }

            return LectureGrid(
              data: widget.controller.lectureList,
              onRefresh: () {
                _loadData();
                return widget.controller.getData(widget.fetchUrl);
              },
              onDelete: (id) =>
                  widget.controller.postDelete(id, widget.deleteUrl),
              onTap: (details) {
                dev.log('Tapped on row: $details');
                hasSelection.value = details != null;
              },
              getObj: (obj) {
                if (obj != null) {
                  dev.log('Selected lecture: ${obj.lectureNameAr}');
                  lecture.value = obj;
                } else {
                  dev.log('Deselected lecture');
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

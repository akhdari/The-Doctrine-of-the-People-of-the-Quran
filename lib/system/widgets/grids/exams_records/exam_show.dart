import 'dart:async';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/controllers/exams/edit_exam_records.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/controllers/exams/exam_records.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/controllers/form_controller.dart'
    as form;
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/models/post/exam_records.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/api_client.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/network/api_endpoints.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/dialogs/exams/exam_records.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/management_buttons_menu.dart';
import 'exam.dart';
import '../../error_illustration.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/three_bounce.dart';

class ExamRecordsScreen extends StatefulWidget {
  const ExamRecordsScreen({super.key});

  @override
  State<ExamRecordsScreen> createState() => _ExamRecordsScreenState();
}

class _ExamRecordsScreenState extends State<ExamRecordsScreen> {
  Duration duration = const Duration(seconds: 5);
  bool minimumLoadTimeCompleted = false;
  late ExamRecordController controller;

  final Rxn<ExamRecordInfoDialog> examRecord = Rxn<ExamRecordInfoDialog>();
  final Duration delay = const Duration(seconds: 5);
  late EditExamRecord editController;
  final RxBool hasSelection = false.obs;

  @override
  void initState() {
    super.initState();
    controller = Get.find<ExamRecordController>();
    _loadData();
  }

  void _loadData() {
    controller.isLoading.value = true;

    Future.wait([
      Future.delayed(duration),
      controller.fetchExamRecords(ApiEndpoints.getSpecialExamRecords),
    ]).then((_) {
      if (mounted) {
        //why check if mounted? bcs the method is being called in the init state method + the future method
        // and bcs it is async by the time the 2 future methods are completed the widget might be disposed
        controller.isLoading.value = false;
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    Get.delete<ExamRecordController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TopButtons(
            onAdd: () {
              if (Get.isRegistered<EditExamRecord>()) {
                hasSelection.value = false;
                examRecord.value = null;
                Get.delete<EditExamRecord>();
              }
              Get.put(form.FormController(14));
              Get.dialog(ExamRecordsDialog());
            },
            onEdit: () {
              if (examRecord.value != null) {
                Get.put(form.FormController(14));
                editController.updateexamRecordInfoDialog(examRecord.value!);
                editController.isEdit = true;
                Get.dialog(ExamRecordsDialog());
              }
            },
            onDelete: () async {
              if (examRecord.value == null) {
                Get.snackbar('Error', 'No guardian selected for deletion');
                return;
              }

              await ApiService.delete(ApiEndpoints.getAccountInfoById(
                  examRecord.value?.exam.examId ?? 0));
              setState(() {
                examRecord.value = null;
                hasSelection.value = false;
                _loadData();
              });
            },
            hasSelection: hasSelection.value,
          ),
        ),
        Expanded(
          child: Obx(() {
            if (controller.isLoading.value) {
              return Center(child: ThreeBounce());
            }

            if (controller.errorMessage.value.isNotEmpty) {
              return ErrorIllustration(
                illustrationPath: 'assets/illustration/bad-connection.svg',
                title: 'Connection Error',
                message: controller.errorMessage.value,
                onRetry: _loadData,
              );
            }

            if (controller.recordsList.isEmpty) {
              return ErrorIllustration(
                illustrationPath: 'assets/illustration/empty-box.svg',
                title: 'No Students Found',
                message:
                    'There are no students registered yet. Click the add button to create one.',
              );
            }

            return RecordsGrid(
                data: controller.recordsList,
                onRefresh: () {
                  _loadData();
                  return controller
                      .fetchExamRecords(ApiEndpoints.getSpecialExamRecords);
                },
                onDelete: (id) => controller.deleteExamRecord(id),
                getObj: (obj) {
                  if (obj != null) {
                    dev.log('Selected lecture: $obj');
                    hasSelection.value = true;
                    examRecord.value = obj;
                  } else {
                    dev.log('Deselected lecture');
                    hasSelection.value = false;
                    examRecord.value = null;
                  }
                });
          }),
        ),
      ],
    );
  }
}

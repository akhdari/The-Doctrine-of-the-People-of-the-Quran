import 'dart:async';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/controllers/edit_exam_notes.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/controllers/exam_notes.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/controllers/form_controller.dart'
    as form;
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/appreciation.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/api_client.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/network/api_endpoints.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/dialogs/exams/exam_notes.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/management_buttons_menu.dart';

import 'exam.dart';
import '../../error_illustration.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/three_bounce.dart';

class ExamNotesScreen extends StatefulWidget {
  const ExamNotesScreen({super.key});

  @override
  State<ExamNotesScreen> createState() => _ExamNotesScreenState();
}

class _ExamNotesScreenState extends State<ExamNotesScreen> {
  Duration duration = const Duration(seconds: 5);
  bool minimumLoadTimeCompleted = false;
  late ExamNotesController controller;

  final Rxn<Appreciation> examRecord = Rxn<Appreciation>();
  final Duration delay = const Duration(seconds: 5);
  late EditExamNotes editController;
  final RxBool hasSelection = false.obs;

  @override
  void initState() {
    super.initState();
    controller = Get.find<ExamNotesController>();
    _loadData();
  }

  void _loadData() {
    controller.isLoading.value = true;

    Future.wait([
      Future.delayed(duration),
      controller.getData(ApiEndpoints.getAppreciations),
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
    Get.delete<ExamNotesController>();
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
              if (Get.isRegistered<EditExamNotes>()) {
                hasSelection.value = false;
                examRecord.value = null;
                Get.delete<EditExamNotes>();
              }
              Get.put(form.FormController(14));
              Get.dialog(AppreciationDialog());
            },
            onEdit: () {
              if (examRecord.value != null) {
                Get.put(form.FormController(14));
                editController.updateexamTeacherInfoDialog(examRecord.value!);
                editController.isEdit = true;
                Get.dialog(AppreciationDialog());
              }
            },
            onDelete: () async {
              if (examRecord.value == null) {
                Get.snackbar('Error', 'No guardian selected for deletion');
                return;
              }

              await ApiService.delete(ApiEndpoints.getAccountInfoById(
                  examRecord.value?.appreciationId ?? 0));
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

            if (controller.notesList.isEmpty) {
              return ErrorIllustration(
                illustrationPath: 'assets/illustration/empty-box.svg',
                title: 'No Students Found',
                message:
                    'There are no students registered yet. Click the add button to create one.',
              );
            }

            return NotesGrid(
                data: controller.notesList,
                onRefresh: () {
                  _loadData();
                  return controller.getData(ApiEndpoints.getAppreciations);
                },
                onDelete: (id) => controller.postDelete(id),
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

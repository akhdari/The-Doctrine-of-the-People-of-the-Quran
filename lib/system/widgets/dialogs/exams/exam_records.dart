import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/controllers/edit_exam_types.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/controllers/form_controller.dart'
    as form;
import 'package:the_doctarine_of_the_ppl_of_the_quran/controllers/submit_form.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/models/post/exam_records.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/student.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/teacher.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/network/api_endpoints.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/utils/const/exam.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/custom_container.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/drop_down.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/image.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/input_field.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/multiselect.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/timer.dart';

class ExamRecordsDialog extends StatefulWidget {
  const ExamRecordsDialog({
    super.key,
  });

  @override
  State<ExamRecordsDialog> createState() => _LectureDialogState();
}

class _LectureDialogState extends State<ExamRecordsDialog> {
  Future<void> loadData() async {
    try {
      final fetchedTeachernNames =
          await getItems<Teacher>(ApiEndpoints.getTeachers, Teacher.fromJson);
      final fetchedStudents =
          await getItems<Student>(ApiEndpoints.getStudents, Student.fromJson);
      dev.log('teacherNames: ${fetchedTeachernNames.toString()}');

      setState(() {
        teacherResult = fetchedTeachernNames;
        studentList = fetchedStudents;
        dev.log('teacherNames: ${teacherResult.toString()}');
      });
    } catch (e) {
      dev.log("Error loading data: $e");
    }
  }

  final GlobalKey<FormState> lectureFormKey = GlobalKey<FormState>();
  late ScrollController scrollController;
  late form.FormController formController;
  final lectureInfo = ExamRecordInfoDialog();
  MultiSelectResult<Teacher>? teacherResult;
  EditExam? editLecture;

  final TextEditingController examDateController = TextEditingController();
  late MultiSelectResult<Student> studentList; // You'll load this like teachers

  @override
  void initState() {
    super.initState();
    if (!Get.isRegistered<form.FormController>()) {
      Get.put(form.FormController(10));
    }

    if (Get.isRegistered<EditExam>()) {
      editLecture = Get.find<EditExam>();
    } else {
      editLecture = null;
    }
    formController = Get.find<form.FormController>();
    scrollController = ScrollController();
    loadData();
  }

  @override
  void dispose() {
    scrollController.dispose();
    if (Get.isRegistered<form.FormController>()) {
      Get.delete<form.FormController>();
    }
    super.dispose();
  }

  RxBool isComplete = true.obs;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: Get.width * 0.7,
        maxHeight: Get.height * 0.8,
        minHeight: 400,
        minWidth: 300,
      ),
      child: Dialog(
        shape: BeveledRectangleBorder(),
        backgroundColor: colorScheme.surface,
        child: Scrollbar(
          controller: scrollController,
          child: Column(
            children: [
              //header
              Stack(children: [
                ColorFiltered(
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.dstIn),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    color: colorScheme.primary,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ClipRRect(
                    child: CustomImage(imagePath: "assets/back.png"),
                  ),
                ),
                Row(
                  children: [
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: colorScheme.onSurface,
                      ),
                      onPressed: () => Get.back(),
                    ),
                  ],
                )
              ]),

              Form(
                key: lectureFormKey,
                child: CustomContainer(
                  headerText: "إضافة اختبار",
                  headerIcon: Icons.school,
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      // Full name (student)
                      Row(children: [
                        Expanded(
                          child: InputField(
                            inputTitle: "الاسم الكامل",
                            child: DropDownWidget<Student>(
                              // Assuming you load this elsewhere
                              items: studentList.items
                                      ?.map((s) => s.obj)
                                      .toList() ??
                                  [],
                              onSaved: (student) {
                                lectureInfo.student = student!;
                              },
                            ),
                          ),
                        ),
                      ]),
                      const SizedBox(height: 8),

                      // Exam type
                      Row(children: [
                        Expanded(
                          child: InputField(
                            inputTitle: "النوع",
                            child: DropDownWidget<String>(
                              items: examTypes,
                              initialValue: examTypes.first,
                              onSaved: (v) => lectureInfo.exam.examType = v!,
                            ),
                          ),
                        ),
                      ]),
                      const SizedBox(height: 8),

                      // Exam date
                      Row(children: [
                        Expanded(
                          child: InputField(
                            inputTitle: "تاريخ الاختبار",
                            child: Obx(
                              () => OutlinedButton(
                                onPressed: () async {
                                  await dateSelector(Get.context!)
                                      .then((value) {
                                    if (value != null) {
                                      lectureInfo.examStudent.dateTakeExam =
                                          value;
                                    }
                                  });
                                },
                                child: Text(lectureInfo
                                        .examStudent.dateTakeExam.value ??
                                    "select date"),
                              ),
                            ),
                          ),
                        ),
                      ]),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),

              // Submit button
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    debugPrint(
                        'Form valid: ${lectureFormKey.currentState?.validate()}');
                    debugPrint(
                        'Fields: ${formController.controllers.map((c) => c.text)}');
                    isComplete.value = false;

                    if (lectureFormKey.currentState?.validate() ?? false) {
                      // Save the form data
                      lectureFormKey.currentState?.save();
                      debugPrint('Form saved: ${lectureInfo.toMap()}');

                      try {
                        // Depending on whether it's an edit or a new submission, call the appropriate endpoint
                        final bool success = editLecture!.exam.value == null
                            ? await submitForm<ExamRecordInfoDialog>(
                                lectureFormKey,
                                lectureInfo,
                                ApiEndpoints.submitLectureForm,
                                (ExamRecordInfoDialog.fromMap))
                            : await submitEditDataForm<ExamRecordInfoDialog>(
                                lectureFormKey,
                                lectureInfo,
                                ApiEndpoints.getSpecialLecture(
                                    editLecture!.exam.value!.examId),
                                (ExamRecordInfoDialog.fromMap));

                        // Handle result based on success
                        if (success) {
                          Get.back(result: true);
                          Get.snackbar(
                              'Success', 'Student data submitted successfully');
                        } else {
                          // Show error message if submission failed
                          Get.snackbar(
                              'Error', 'Failed to submit lecture data');
                        }
                      } catch (e) {
                        // Handle any errors during submission
                        Get.snackbar('Error',
                            'An error occurred while submitting the form');
                        debugPrint('Error submitting form: $e');
                      } finally {
                        // Ensure to re-enable the submit button
                        isComplete.value = true;
                      }
                    } else {
                      // If form is invalid, show an error message
                      Get.snackbar(
                          'Error', 'Please fill out all required fields');
                      isComplete.value = true;
                    }
                  },
                  child: Obx(() => isComplete.value
                      ? Text('Submit')
                      : CircularProgressIndicator()),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

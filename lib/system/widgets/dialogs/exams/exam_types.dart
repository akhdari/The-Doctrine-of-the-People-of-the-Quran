import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/controllers/edit_exam_types.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/controllers/form_controller.dart'
    as form;
import 'package:the_doctarine_of_the_ppl_of_the_quran/controllers/submit_form.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/controllers/validator.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/exam.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/teacher.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/network/api_endpoints.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/utils/const/exam.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/custom_container.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/drop_down.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/image.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/input_field.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/multiselect.dart';

class ExamTypesDialog extends StatefulWidget {
  const ExamTypesDialog({
    super.key,
  });

  @override
  State<ExamTypesDialog> createState() => _LectureDialogState();
}

class _LectureDialogState extends State<ExamTypesDialog> {
  Future<void> loadData() async {
    try {
      final fetchedTeachernNames =
          await getItems<Teacher>(ApiEndpoints.getTeachers, Teacher.fromJson);

      dev.log('teacherNames: ${fetchedTeachernNames.toString()}');

      setState(() {
        teacherResult = fetchedTeachernNames;
        dev.log('teacherNames: ${teacherResult.toString()}');
      });
    } catch (e) {
      dev.log("Error loading data: $e");
    }
  }

  final GlobalKey<FormState> lectureFormKey = GlobalKey<FormState>();
  late ScrollController scrollController;
  late form.FormController formController;
  final lectureInfo = Exam();
  MultiSelectResult<Teacher>? teacherResult;
  EditExam? editLecture;

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

              // Form
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(20),
                  child: Form(
                      key: lectureFormKey,
                      child: CustomContainer(
                        headerText: "إضافة اختبار",
                        headerIcon: Icons.school,
                        child: Column(
                          children: [
                            Row(children: [
                              Expanded(
                                child: InputField(
                                  inputTitle: "اسم الاختبار",
                                  child: CustomTextField(
                                    controller: formController.controllers[0],
                                    validator: (v) =>
                                        Validator.notEmptyValidator(
                                            v, "الاسم مطلوب"),
                                    onSaved: (v) => lectureInfo.examNameAr = v!,
                                  ),
                                ),
                              ),
                            ]),
                            const SizedBox(height: 8),
                            Row(children: [
                              Expanded(
                                child: InputField(
                                  inputTitle: "نوع الاختبار",
                                  child: DropDownWidget<String>(
                                    items: examTypes, // You define this list
                                    initialValue: examTypes[0],
                                    onSaved: (v) => lectureInfo.examType = v!,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                            ]),
                            const SizedBox(height: 8),
                            Row(children: [
                              Expanded(
                                  child: _numericField("الدرجة العظمى", 1)),
                              const SizedBox(width: 8),
                              Expanded(child: _numericField("علامة النجاح", 2)),
                            ]),
                            const SizedBox(height: 8),
                            Row(children: [
                              Expanded(child: _numericField("درجة الحفظ", 3)),
                              const SizedBox(width: 8),
                              Expanded(
                                  child: _numericField(
                                      "درجة التجويد التطبيقي", 4)),
                            ]),
                            const SizedBox(height: 8),
                            Row(children: [
                              Expanded(
                                  child:
                                      _numericField("درجة التجويد النظري", 5)),
                              const SizedBox(width: 8),
                              Expanded(child: _numericField("درجة الأداء", 6)),
                            ]),
                            const SizedBox(height: 8),
                          ],
                        ),
                      )),
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
                      debugPrint('Form saved: ${lectureInfo.toJson()}');

                      try {
                        // Depending on whether it's an edit or a new submission, call the appropriate endpoint
                        final bool success = editLecture!.exam.value == null
                            ? await submitForm<Exam>(
                                lectureFormKey,
                                lectureInfo,
                                ApiEndpoints.submitLectureForm,
                                (Exam.fromJson))
                            : await submitEditDataForm<Exam>(
                                lectureFormKey,
                                lectureInfo,
                                ApiEndpoints.getSpecialLecture(
                                    editLecture!.exam.value!.examId),
                                (Exam.fromJson));

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

  Widget _numericField(String title, int controllerIndex) {
    return InputField(
      inputTitle: title,
      child: CustomTextField(
        controller: formController.controllers[controllerIndex],
        keyboardType: TextInputType.number,
        onSaved: (v) {
          switch (controllerIndex) {
            case 1:
              lectureInfo.examMaxPoint = double.tryParse(v ?? '') ?? 0;
              break;
            case 2:
              lectureInfo.examSucessMinPoint = double.tryParse(v ?? '') ?? 0;
              break;
            case 3:
              lectureInfo.examMemoPoint = double.tryParse(v ?? '') ?? 0;
              break;
            case 4:
              lectureInfo.examTjwidAppPoint = double.tryParse(v ?? '') ?? 0;
              break;
            case 5:
              lectureInfo.examTjwidThoPoint = double.tryParse(v ?? '') ?? 0;
              break;
            case 6:
              lectureInfo.examPerformancePoint = double.tryParse(v ?? '') ?? 0;
              break;
          }
        },
      ),
    );
  }
}

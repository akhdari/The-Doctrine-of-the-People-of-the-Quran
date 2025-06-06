import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/teacher.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/network/api_endpoints.dart';
import '../../utils/const/lecture.dart';
import '../drop_down.dart';
import '../../../controllers/submit_form.dart';
import '../../models/post/lecture.dart';

import '../../../controllers/validator.dart';
import '../../../controllers/edit_lecture.dart';
import '../custom_container.dart';
import '../input_field.dart';
import '../custom_matrix.dart';
import '../multiselect.dart';
import 'dart:developer' as dev;
import '../image.dart';
import '../../../../controllers/generate.dart';
import '../../../controllers/form_controller.dart' as form;

class LectureDialog extends StatefulWidget {
  const LectureDialog({
    super.key,
  });

  @override
  State<LectureDialog> createState() => _LectureDialogState();
}

class _LectureDialogState extends State<LectureDialog> {
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
  final lectureInfo = LectureForm();
  MultiSelectResult<Teacher>? teacherResult;
  EditLecture? editLecture;

  @override
  void initState() {
    super.initState();
    if (!Get.isRegistered<form.FormController>()) {
      Get.put(form.FormController(10));
    }
    Get.put(Generate());
    if (Get.isRegistered<EditLecture>()) {
      editLecture = Get.find<EditLecture>();
    } else {
      editLecture = null;
    }
    formController = Get.find<form.FormController>();
    scrollController = ScrollController();
    loadData();
    if (!Get.isRegistered<TimeCellController>()) {
      Get.put(TimeCellController());
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    if (Get.isRegistered<form.FormController>()) {
      Get.delete<form.FormController>();
    }
    if (Get.isRegistered<TimeCellController>()) {
      Get.delete<TimeCellController>();
    }
    super.dispose();
  }

  RxBool isComplete = true.obs;
  @override
  Widget build(BuildContext context) {
    final TimeCellController timeCellController =
        Get.find<TimeCellController>();
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
                    child: Column(
                      children: [
                        CustomContainer(
                          headerText: "lecture info",
                          headerIcon: Icons.person,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: InputField(
                                      inputTitle: "lecture name in arabic",
                                      child: CustomTextField(
                                        controller: editLecture != null
                                            ? editLecture!.lectureNameAr
                                            : formController.controllers[0],
                                        validator: (value) =>
                                            Validator.notEmptyValidator(
                                                value, "يجب ادخال الاسم"),
                                        focusNode: formController.focusNodes[0],
                                        onSaved: (p0) => lectureInfo
                                            .lecture.lectureNameAr = p0!,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: InputField(
                                      inputTitle: "lecture name in english",
                                      child: CustomTextField(
                                        controller: editLecture != null
                                            ? editLecture!.lectureNameEn
                                            : formController.controllers[1],
                                        validator: (value) =>
                                            Validator.notEmptyValidator(
                                                value, "يجب ادخال الاسم"),
                                        focusNode: formController.focusNodes[1],
                                        onSaved: (p0) => lectureInfo
                                            .lecture.lectureNameEn = p0!,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: InputField(
                                      inputTitle: "lecture type",
                                      child: DropDownWidget<String>(
                                        items: type,
                                        initialValue: editLecture != null
                                            ? editLecture!.lecture.value
                                                    ?.lecture.circleType ??
                                                type[0]
                                            : type[0],
                                        onSaved: (p0) => lectureInfo
                                            .lecture.circleType = p0!,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              InputField(
                                inputTitle: "teachers",
                                child: MultiSelect<Teacher>(
                                  getPickedItems: (pickedItems) {
                                    lectureInfo.teachers =
                                        pickedItems.map((e) => e.obj).toList();
                                  },
                                  preparedData: teacherResult?.items ?? [],
                                  hintText: "search by teacher name",
                                  maxSelectedItems: null,
                                  initialPickedItems: editLecture!
                                              .lecture.value !=
                                          null
                                      ? teacherResult?.items
                                              ?.where((element) => editLecture!
                                                  .teacherIds
                                                  .contains(element.obj))
                                              .toList() ??
                                          []
                                      : null,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              InputField(
                                  inputTitle: "show on website?",
                                  child: DropDownWidget<bool>(
                                      items: trueFalse,
                                      initialValue: editLecture != null
                                          ? editLecture!.lecture.value!.lecture
                                              .shownOnWebsite
                                          : true,
                                      onSaved: (p0) {
                                        lectureInfo.lecture.shownOnWebsite =
                                            transformBool(p0!);
                                      }))
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomContainer(
                          headerIcon: Icons.alarm,
                          headerText: "schedule info",
                          child: CustomMatrix(
                            controller: timeCellController,
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
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

                    lectureInfo.schedules =
                        timeCellController.getSelectedDays();
                    isComplete.value = false;

                    if (lectureFormKey.currentState?.validate() ?? false) {
                      // Save the form data
                      lectureFormKey.currentState?.save();
                      debugPrint('Form saved: ${lectureInfo.toMap()}');

                      try {
                        // Depending on whether it's an edit or a new submission, call the appropriate endpoint
                        final bool success = editLecture!.lecture.value == null
                            ? await submitForm<LectureForm>(
                                lectureFormKey,
                                lectureInfo,
                                ApiEndpoints.submitLectureForm,
                                (LectureForm.fromJson))
                            : await submitEditDataForm<LectureForm>(
                                lectureFormKey,
                                lectureInfo,
                                ApiEndpoints.getSpecialLecture(editLecture!
                                    .lecture.value!.lecture.lectureId),
                                (LectureForm.fromJson));

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

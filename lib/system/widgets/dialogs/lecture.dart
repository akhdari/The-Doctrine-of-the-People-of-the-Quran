import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/controllers/generic_edit_controller.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/teacher.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/network/api_endpoints.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/dialogs/dialog.dart';
import '../../utils/const/lecture.dart';
import '../drop_down.dart';
import '../../../controllers/submit_form.dart';
import '../../models/post/lecture.dart';
import '../../../controllers/validator.dart';
import '../custom_container.dart';
import '../input_field.dart';
import '../custom_matrix.dart';
import '../multiselect.dart';
import 'dart:developer' as dev;

class LectureDialog extends GlobalDialog {
  const LectureDialog(
      {super.key, super.dialogHeader = "إضافة حصة", super.numberInputs = 2});

  @override
  State<GlobalDialog> createState() =>
      _LectureDialogState<GenericEditController<LectureForm>>();
}

class _LectureDialogState<GEC extends GenericEditController<LectureForm>>
    extends DialogState<GEC> {
  @override
  Future<void> loadData() async {
    try {
      final fetchedTeachernNames =
          await getItems<Teacher>(ApiEndpoints.getTeachers, Teacher.fromJson);

      dev.log('teacherNames: ${fetchedTeachernNames.toString()}');

      setState(() {
        teacherResult = fetchedTeachernNames;
        dev.log('teacherNames: ${teacherResult.toString()}');

        // Set default values after loading teacher list
        if (editController?.model.value != null) {
          setDefaultFieldsValue();
        }
      });
    } catch (e) {
      dev.log("Error loading data: $e");
    }
  }

  late final TimeCellController timeCellController;
  final lectureInfo = LectureForm();
  MultiSelectResult<Teacher>? teacherResult;

  String selectedLectureType = type.isNotEmpty ? type[0] : '';
  bool showOnWebsite = true;
  List<MultiSelectItem<Teacher>>? selectedTeachers = [];

  @override
  void initState() {
    super.initState();
    if (!Get.isRegistered<TimeCellController>()) {
      Get.put(TimeCellController());
    }
    timeCellController = Get.find<TimeCellController>();
  }

  @override
  void dispose() {
    super.dispose();
    timeCellController.dispose();
    if (Get.isRegistered<TimeCellController>()) {
      Get.delete<TimeCellController>();
    }
  }

  @override
  Column formChild() {
    return Column(
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
                        controller: formController.controllers[0],
                        validator: (value) => Validator.notEmptyValidator(
                            value, "يجب ادخال الاسم"),
                        focusNode: formController.focusNodes[0],
                        onSaved: (p0) =>
                            lectureInfo.lecture.lectureNameAr = p0!,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: InputField(
                      inputTitle: "lecture name in english",
                      child: CustomTextField(
                        controller: formController.controllers[1],
                        validator: (value) => Validator.notEmptyValidator(
                            value, "يجب ادخال الاسم"),
                        focusNode: formController.focusNodes[1],
                        onSaved: (p0) =>
                            lectureInfo.lecture.lectureNameEn = p0!,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      inputTitle: "lecture type",
                      child: DropDownWidget<String>(
                        items: type,
                        initialValue: selectedLectureType,
                        onSaved: (p0) => lectureInfo.lecture.circleType = p0!,
                        onChanged: (p0) {
                          setState(() => selectedLectureType = p0!);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              InputField(
                inputTitle: "teachers",
                child: MultiSelect<Teacher>(
                  getPickedItems: (pickedItems) {
                    lectureInfo.teachers =
                        pickedItems.map((e) => e.obj).toList();
                    selectedTeachers = pickedItems;
                  },
                  preparedData: teacherResult?.items ?? [],
                  hintText: "search by teacher name",
                  maxSelectedItems: null,
                  initialPickedItems: selectedTeachers ?? [],
                ),
              ),
              const SizedBox(height: 8),
              InputField(
                inputTitle: "show on website?",
                child: DropDownWidget<bool>(
                  items: trueFalse,
                  initialValue: showOnWebsite,
                  onSaved: (p0) {
                    lectureInfo.lecture.shownOnWebsite = transformBool(p0!);
                  },
                  onChanged: (p0) {
                    setState(() => showOnWebsite = p0!);
                  },
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
        CustomContainer(
          headerIcon: Icons.alarm,
          headerText: "schedule info",
          child: CustomMatrix(
            controller: timeCellController,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  @override
  Future<bool> submit() async {
    return editController?.model.value == null
        ? await submitForm<LectureForm>(lectureFormKey, lectureInfo,
            ApiEndpoints.submitLectureForm, (LectureForm.fromJson))
        : await submitEditDataForm<LectureForm>(
            lectureFormKey,
            lectureInfo,
            ApiEndpoints.getSpecialLecture(
                editController!.model.value!.lecture.lectureId),
            (LectureForm.fromJson));
  }

  @override
  void setDefaultFieldsValue() {
    final s = editController!.model.value!;
    formController.controllers[0].text = s.lecture.lectureNameAr ?? "";
    formController.controllers[1].text = s.lecture.lectureNameEn ?? "";
    // Ensure the value exists in type
    if (type.contains(s.lecture.circleType)) {
      selectedLectureType = s.lecture.circleType!;
    } else {
      selectedLectureType = type.isNotEmpty ? type[0] : '';
    }
    showOnWebsite = s.lecture.shownOnWebsite;

    if (teacherResult != null) {
      selectedTeachers = teacherResult!.items
          ?.where((element) =>
              editController!.model.value?.teachers.contains(element.obj) ??
              false)
          .toList();
    }
  }
}

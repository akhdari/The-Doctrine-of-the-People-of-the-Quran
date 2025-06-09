import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/controllers/form_controller.dart'
    as form;
import 'package:the_doctarine_of_the_ppl_of_the_quran/controllers/generic_edit_controller.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/controllers/submit_form.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/controllers/validator.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/exam.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/teacher.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/network/api_endpoints.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/utils/const/exam.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/dialogs/dialog.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/drop_down.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/input_field.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/multiselect.dart';

class ExamTypesDialog extends GlobalDialog {
  const ExamTypesDialog(
      {super.key,
      super.dialogHeader = "إضافة اختبار",
      super.numberInputs = 10});

  @override
  State<GlobalDialog> createState() =>
      _ExamTypesDialogState<GenericEditController<Exam>>();
}

class _ExamTypesDialogState<GEC extends GenericEditController<Exam>>
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
      });
    } catch (e) {
      dev.log("Error loading data: $e");
    }
  }

  final lectureInfo = Exam();
  MultiSelectResult<Teacher>? teacherResult;
  GenericEditController<Exam>? editExam;

  @override
  void dispose() {
    scrollController.dispose();
    if (Get.isRegistered<form.FormController>()) {
      Get.delete<form.FormController>();
    }
    super.dispose();
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

  @override
  Column formChild() {
    return Column(
      children: [
        Row(children: [
          Expanded(
            child: InputField(
              inputTitle: "اسم الاختبار",
              child: CustomTextField(
                controller: formController.controllers[0],
                validator: (v) => Validator.notEmptyValidator(v, "الاسم مطلوب"),
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
          Expanded(child: _numericField("الدرجة العظمى", 1)),
          const SizedBox(width: 8),
          Expanded(child: _numericField("علامة النجاح", 2)),
        ]),
        const SizedBox(height: 8),
        Row(children: [
          Expanded(child: _numericField("درجة الحفظ", 3)),
          const SizedBox(width: 8),
          Expanded(child: _numericField("درجة التجويد التطبيقي", 4)),
        ]),
        const SizedBox(height: 8),
        Row(children: [
          Expanded(child: _numericField("درجة التجويد النظري", 5)),
          const SizedBox(width: 8),
          Expanded(child: _numericField("درجة الأداء", 6)),
        ]),
        const SizedBox(height: 8),
      ],
    );
  }

  @override
  void setDefaultFieldsValue() {
    // TODO: implement setDefaultFieldsValue
  }

  @override
  Future<bool> submit() async {
    return editExam!.model.value == null
        ? await submitForm<Exam>(lectureFormKey, lectureInfo,
            ApiEndpoints.submitLectureForm, (Exam.fromJson))
        : await submitEditDataForm<Exam>(
            lectureFormKey,
            lectureInfo,
            ApiEndpoints.getSpecialLecture(editExam!.model.value!.examId),
            (Exam.fromJson));
  }
}

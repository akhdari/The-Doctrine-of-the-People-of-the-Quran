import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/controllers/generic_edit_controller.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/controllers/submit_form.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/models/post/exam_records.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/student.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/teacher.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/network/api_endpoints.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/utils/const/exam.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/dialogs/dialog.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/drop_down.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/input_field.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/multiselect.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/time_picker.dart';

class ExamRecordsDialog extends GlobalDialog {
  const ExamRecordsDialog(
      {super.key,
      super.dialogHeader = "إضافة اختبار",
      super.numberInputs = 10});

  @override
  State<GlobalDialog> createState() =>
      _LectureDialogState<GenericEditController<ExamRecordInfoDialog>>();
}

class _LectureDialogState<
        GEC extends GenericEditController<ExamRecordInfoDialog>>
    extends DialogState<GEC> {
  final lectureInfo = ExamRecordInfoDialog();
  MultiSelectResult<Teacher>? teacherResult;
  MultiSelectResult<Student>? studentList;

  @override
  ListView formChild() {
    return ListView(
      children: [
        const SizedBox(height: 8),
        // Full name (student)
        Row(children: [
          Expanded(
            child: InputField(
              inputTitle: "الاسم الكامل",
              child: DropDownWidget<Student>(
                // Assuming you load this elsewhere
                items: studentList?.items?.map((s) => s.obj).toList() ?? [],
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
                    await showCustomTimePicker(
                      context: Get.context!,
                      initialTime: TimeOfDay.now(),
                    ).then((value) {
                      if (value != null) {
                        // Format time as string or store TimeOfDay directly depending on your model
                        lectureInfo.examStudent.dateTakeExam =
                            "${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}";
                      }
                    });
                  },
                  child: Text(lectureInfo.examStudent.dateTakeExam.value ??
                      "select date"),
                ),
              ),
            ),
          ),
        ]),
        const SizedBox(height: 8),
      ],
    );
  }

  @override
  Future<void> loadData() async {
    try {
      final fetchedTeachernNames =
          await getItems<Teacher>(ApiEndpoints.getTeachers, Teacher.fromJson);
      final fetchedStudents =
          await getItems<Student>(ApiEndpoints.getStudents, Student.fromJson);
      dev.log('teacherNames: ${fetchedTeachernNames.toString()}');

      super.setState(() {
        teacherResult = fetchedTeachernNames;
        studentList = fetchedStudents;
        dev.log('teacherNames: ${teacherResult.toString()}');
      });
    } catch (e) {
      dev.log("Error loading data: $e");
    }
  }

  @override
  Future<bool> submit() async {
    return super.editController!.model.value == null
        ? await submitForm<ExamRecordInfoDialog>(formKey, lectureInfo,
            ApiEndpoints.submitLectureForm, (ExamRecordInfoDialog.fromJson))
        : await submitEditDataForm<ExamRecordInfoDialog>(
            formKey,
            lectureInfo,
            ApiEndpoints.getSpecialLecture(
                editController!.model.value?.exam.examId ?? -1),
            (ExamRecordInfoDialog.fromJson));
  }

  @override
  void setDefaultFieldsValue() {
    // TODO: implement setDefaultFieldsValue
  }
}

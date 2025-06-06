import 'package:get/get.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/models/post/exam_teachers.dart';

class EditExamTeachers extends GetxController {
  final Rx<ExamTeacherInfoDialog?> examTeacher;

  bool isEdit = false;
  EditExamTeachers(
      {required ExamTeacherInfoDialog? initialExamTeacher,
      required this.isEdit})
      : examTeacher = initialExamTeacher.obs;

  void updateExamTeacher(ExamTeacherInfoDialog newExamTeacher) {
    examTeacher.value = newExamTeacher;
  }
}

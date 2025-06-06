import 'package:get/get.dart';

import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/exam.dart';

class EditExam extends GetxController {
  final Rx<Exam?> exam;

  bool isEdit = false;
  EditExam({required Exam? initialExam, required this.isEdit})
      : exam = initialExam.obs;

  void updateExam(Exam newExam) {
    exam.value = newExam;
  }
}

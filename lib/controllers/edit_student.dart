import 'package:get/get.dart';

import 'package:the_doctarine_of_the_ppl_of_the_quran/system/models/post/student.dart';

class EditStudent extends GetxController {
  final Rx<StudentInfoDialog?> lecture;

  bool isEdit = false;
  EditStudent(
      {required StudentInfoDialog? initialLecture, required this.isEdit})
      : lecture = initialLecture.obs;

  void updateLecture(StudentInfoDialog newLecture) {
    lecture.value = newLecture;
  }
}

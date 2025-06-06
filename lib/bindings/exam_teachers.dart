import 'package:get/get.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/controllers/exam_teachers.dart';

class ExamTeacherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExamTeacherController());
  }
}

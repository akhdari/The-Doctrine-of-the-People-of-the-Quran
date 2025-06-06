import 'package:get/get.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/controllers/exams/exam_notes.dart';

class ExamNotesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExamNotesController());
  }
}

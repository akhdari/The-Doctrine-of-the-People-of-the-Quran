import 'package:get/get.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/controllers/exams/exam_records.dart';

class ExamRecordsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExamRecordController());
  }
}

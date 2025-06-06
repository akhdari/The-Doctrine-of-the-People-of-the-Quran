import 'package:get/get.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/models/post/exam_records.dart';

class EditExamRecord extends GetxController {
  final Rx<ExamRecordInfoDialog?> examRecordInfoDialog;

  bool isEdit = false;
  EditExamRecord(
      {required ExamRecordInfoDialog? initialexamRecordInfoDialog,
      required this.isEdit})
      : examRecordInfoDialog = initialexamRecordInfoDialog.obs;

  void updateexamRecordInfoDialog(
      ExamRecordInfoDialog newexamRecordInfoDialog) {
    examRecordInfoDialog.value = newexamRecordInfoDialog;
  }
}

import 'package:get/get.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/appreciation.dart';

class EditExamNotes extends GetxController {
  final Rx<Appreciation?> examTeacherInfoDialog;

  bool isEdit = false;
  EditExamNotes({required Appreciation? appreciation, required this.isEdit})
      : examTeacherInfoDialog = appreciation.obs;

  void updateexamTeacherInfoDialog(Appreciation appreciation) {
    examTeacherInfoDialog.value = appreciation;
  }
}

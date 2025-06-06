import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/models/post/guardian.dart';

class EditGuardian extends GetxController {
  final Rx<GuardianInfoDialog?> guardian;

  bool isEdit = false;
  EditGuardian(
      {required GuardianInfoDialog? initialLecture, required this.isEdit})
      : guardian = initialLecture.obs;

  void updateGuardian(GuardianInfoDialog newLecture) {
    guardian.value = newLecture;
  }
}

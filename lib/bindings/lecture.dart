import 'package:get/get.dart';
import '../controllers/lecture.dart';
import '../controllers/form_controller.dart' as form;

class LectureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LectureController());
    Get.lazyPut(() => form.FormController(10));
  }
}

import 'package:get/get.dart';
import '../controllers/student.dart';

class StudentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StudentController());
  }
}

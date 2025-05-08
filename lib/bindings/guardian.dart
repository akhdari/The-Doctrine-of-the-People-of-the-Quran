import 'package:get/get.dart';
import '../controllers/guardian.dart';

class GuardianBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GuardianController());
  }
}

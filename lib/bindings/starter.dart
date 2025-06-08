import 'package:get/get.dart';
//import '../controllers/theme.dart';
import '../controllers/font_loader.dart';
import '../controllers/profile_controller.dart';
import '../controllers/drawer_controller.dart' as mydrawer;

class StarterBinding extends Bindings {
  @override
  void dependencies() {
    // Lazy put controllers (created on demand)
    Get.put(() => FontController());

    //need to be available immediately (singleton)
    Get.put(ProfileController());
    Get.put(mydrawer.DrawerController());
    //Get.put(() => ThemeController());
  }
}

import 'package:get/get.dart';

// Core screens
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/attendance/attendance.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/testpage.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/flipcard.dart';

// Report screens (namespaced)
import '../screens/report1_screen.dart' as report1;
import '../screens/report2_screen.dart' as report2;
import '../screens/report3_screen.dart' as report3;
import '../screens/report4_screen.dart' as report4;

// Stats screens
import 'package:the_doctarine_of_the_ppl_of_the_quran/stats/stat1.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/stats/stat2.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/stats/stat3.dart';

// Bindings for dependency injection
import '../bindings/attendance_binding.dart';
import '../bindings/stat1_binding.dart';
import '../bindings/stat2_binding.dart';
import '../bindings/stat3_binding.dart';
//import 'package:test_app/bindings/stat4_binding.dart';

// Routes constants
import 'app_routes.dart';

class AppPages {
  static final routes = [
    // Initial and attendance screens
    GetPage(name: AppRoutes.INITIAL, page: () => TestPage()),
    GetPage(
      name: AppRoutes.ATTENDANCE,
      page: () => AttendanceScreen(),
      binding: AttendanceBinding(),
    ),

    // Report screens
    GetPage(name: AppRoutes.REPORT1, page: () => report1.Report1Screen()),
    GetPage(name: AppRoutes.REPORT2, page: () => report2.Report2Screen()),
    GetPage(name: AppRoutes.REPORT3, page: () => report3.Report3Screen()),
    GetPage(name: AppRoutes.REPORT4, page: () => report4.Report4Screen()),

    // Other utility screens
    GetPage(name: AppRoutes.TEST, page: () => const TestPage()),
    GetPage(name: AppRoutes.CARD, page: () => const StudentSelectionPage()),

    // Stats screens with bindings
    GetPage(
      name: AppRoutes.STAT1,
      page: () => StudentProgressChartScreen(),
      binding: Stat1Binding(),
    ),
    GetPage(
      name: AppRoutes.STAT2,
      page: () => AttendanceChartScreen(),
      binding: Stat2Binding(),
    ),
    GetPage(
      name: AppRoutes.STAT3,
      page: () => PerformanceChartScreen(),
      binding: Stat3Binding(),
    ),
    // You can add STAT4 here if needed, with page and binding
  ];
}

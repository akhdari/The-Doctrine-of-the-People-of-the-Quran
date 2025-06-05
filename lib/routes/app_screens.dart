import 'package:get/get.dart';
import '../system/screens/copy.dart';
import '../bindings/copy.dart';
import '../system/screens/add_student.dart';
import '../bindings/student.dart';
import '../system/screens/add_guardian.dart';
import '../bindings/guardian.dart';
import '../system/screens/add_lecture.dart';
import '../bindings/lecture.dart';
import '../system/screens/add_acheivement.dart';
import '../bindings/acheivement.dart';
import '../testpage.dart';
import '../bindings/theme.dart';
import '../system/screens/login.dart';
// Core screens
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/attendance/attendance.dart';
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
import 'package:the_doctarine_of_the_ppl_of_the_quran/bindings/attendance_binding.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/bindings/stat1_binding.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/bindings/stat2_binding.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/bindings/stat3_binding.dart';

//import 'package:test_app/bindings/stat4_binding.dart';

class Routes {
  static const test = '/test';
  static const copy = '/copy';
  static const logIn = '/logIn';
  static const addStudent = '/add_student';
  static const addGuardian = '/add_guardian';
  static const addLecture = '/add_lecture';
  static const addAcheivement = '/add_acheivement';
  static const attendance = '/attendance';
  static const INITIAL = '/';
  static const REPORT1 = '/report1';
  static const REPORT2 = '/report2';
  static const REPORT3 = '/report3';
  static const REPORT4 = '/report4';
  static const CARD = '/card';
  static const TEST = '/test';
  static const STAT1 = '/stat1';
  static const STAT2 = '/stat2';
  static const STAT3 = '/stat3';
  static const STAT4 = '/stat4';
}

class AppScreens {
  static final routes = [
    GetPage(
      name: Routes.copy,
      page: () => CopyPage(),
      binding: CopyBinding(),
    ),
    GetPage(
      name: Routes.addStudent,
      page: () => AddStudent(),
      binding: StudentBinding(),
    ),
    GetPage(
      name: Routes.addGuardian,
      page: () => AddGuardian(),
      binding: GuardianBinding(),
    ),
    GetPage(
      name: Routes.addLecture,
      page: () => AddLecture(),
      binding: LectureBinding(),
    ),
    GetPage(
      name: Routes.addAcheivement,
      page: () => AddAcheivement(),
      binding: AcheivementBinding(),
    ),
    GetPage(
      name: Routes.TEST,
      page: () => TestPage(),
      binding: ThemeBinding(),
    ),
    GetPage(
      name: Routes.logIn,
      page: () => LogInPage(),
    ),
    GetPage(
      name: Routes.attendance,
      page: () => AttendanceScreen(),
      binding: AttendanceBinding(),
    ),
    GetPage(
      name: Routes.INITIAL,
      page: () => TestPage(),
    ),

    // Report screens
    GetPage(name: Routes.REPORT1, page: () => report1.Report1Screen()),
    GetPage(name: Routes.REPORT2, page: () => report2.Report2Screen()),
    GetPage(name: Routes.REPORT3, page: () => report3.Report3Screen()),
    GetPage(name: Routes.REPORT4, page: () => report4.Report4Screen()),

    // Other utility screens
    GetPage(name: Routes.TEST, page: () => const TestPage()),
    GetPage(name: Routes.CARD, page: () => const StudentSelectionPage()),

    // Stats screens with bindings
    GetPage(
      name: Routes.STAT1,
      page: () => StudentProgressChartScreen(),
      binding: Stat1Binding(),
    ),
    GetPage(
      name: Routes.STAT2,
      page: () => AttendanceChartScreen(),
      binding: Stat2Binding(),
    ),
    GetPage(
      name: Routes.STAT3,
      page: () => PerformanceChartScreen(),
      binding: Stat3Binding(),
    ),
  ];
}

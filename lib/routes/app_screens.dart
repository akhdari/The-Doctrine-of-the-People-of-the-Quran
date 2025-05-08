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

class Routes {
  static const test = '/test';
  static const copy = '/copy';
  static const logIn = '/logIn';
  static const addStudent = '/add_student';
  static const addGuardian = '/add_guardian';
  static const addLecture = '/add_lecture';
  static const addAcheivement = '/add_acheivement';
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
      name: Routes.copy,
      page: () => CopyPage(),
      binding: CopyBinding(),
    ),
    GetPage(
      name: Routes.test,
      page: () => TestPage(),
      binding: ThemeBinding(),
    ),
    GetPage(
      name: Routes.logIn,
      page: () => LogInPage(),
      //  binding:,
    ),
  ];
}

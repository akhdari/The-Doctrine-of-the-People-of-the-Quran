import 'package:flutter/material.dart';
import 'testpage.dart';
import 'package:get/get.dart';
import 'system/utils/theme.dart';
import 'controllers/theme.dart';
import 'routes/app_screens.dart';
import 'bindings/theme.dart';

void main() {
  Get.put(ThemeController());
  runApp(MyApp());
}

/*
class TestAttendance extends StatefulWidget {
  const TestAttendance({super.key});

  @override
  State<TestAttendance> createState() => _TestAttendanceState();
}

class _TestAttendanceState extends State<TestAttendance> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Attendance(),
    );
  }
}
*/
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeController themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeController.mode.value,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          initialBinding: ThemeBinding(),
          getPages: AppScreens.routes,
          home: TestPage(),
        ));
  }
}

// https://rydmike.com/flexcolorscheme/themesplayground-latest/

import 'package:flutter/material.dart';
import 'testpage.dart';
import 'web/pages/copy.dart';
import 'package:get/get.dart';
import 'web/pages/logIn.dart';
import 'system/utils/theme.dart';
import 'system/screens/add_student.dart';
import 'system/screens/add_guardian.dart';
import 'system/screens/add_lecture.dart';
import 'system/screens/add_acheivement.dart';
import 'controllers/theme.dart';

void main() {
  Get.put(ThemeController()); //globally accessible
  runApp(MyApp());
}

// initState() is called when the widget is inserted into the widget tree
// initState can not be async
//but we can call an async function inside

class MyApp extends StatefulWidget {
  const MyApp({super.key}); //const MyApp();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Used to select if we use the dark or light theme, start with system mode.
  //ThemeMode themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    // you should wrap the widget that is being updated with Obx, not the widget that is updating the value.
    return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          //the theme should be used
          themeMode: Get.find<ThemeController>().mode.value, //ThemeMode.light
          theme: AppTheme.light, //defines light theme of the app
          darkTheme: AppTheme.dark,
          routes: {
            '/copy': (context) => const CopyPage(),
            '/logIn': (context) => const LogInPage(),
            '/add_student': (context) => AddStudent(),
            '/add_guardian': (context) => AddGuardian(),
            '/add_lecture': (context) => AddLecture(),
            '/add_acheivement': (context) => AddAcheivement(),
          },
          home: EmptyPage(),
        ));
  }
}

/*
visit: https://rydmike.com/flexcolorscheme/themesplayground-latest/
play with the themes
copy theme code
*/
/// The [AppTheme] defines light and dark themes for the app.
/// Use it in a [MaterialApp] like this:
///
/// MaterialApp(
///   theme: AppTheme.light,
///   darkTheme: AppTheme.dark,
/// );
/// white/light gray for light mode and black/dark gray for dark mode

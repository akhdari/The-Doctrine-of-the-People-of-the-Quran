import 'package:flutter/material.dart';
import 'pages/testpage.dart';
import 'pages/copy_page.dart';
import 'package:get/get.dart';
import 'pages/login_page.dart';
import '../system/file3.dart';
import '../system/ui.dart';
import '../system/widgets/theme.dart';

List<String> columnLabels = [
  'first_name_ar',
  'last_name_ar',
  'sex',
  'date_of_birth',
  'place_of_birth',
  'nationality',
  'lecture_name_ar',
  'username'
];

List<String> rowLabels =
    //should match the data list map keys
    [
  'first_name_ar',
  'last_name_ar',
  'sex',
  'date_of_birth',
  'place_of_birth',
  'nationality',
  'lecture_name_ar',
  'username'
];

void main() {
  Get.put(ThemeController()); //globally accessible
  runApp(MyApp());
}

// initState() is called when the widget is inserted into the widget tree
// initState can not be async
//but we can call an async function inside

class MyApp extends StatefulWidget {
  MyApp();

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
            '/test': (context) => const EmptyPage(),
            '/table': (context) => CustomDataTable(
                rowsPerPage: 2, colums: columnLabels, rows: rowLabels),
            "ui": (context) => SystemUI()
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

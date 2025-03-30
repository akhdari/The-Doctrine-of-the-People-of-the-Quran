import 'package:flutter/material.dart';
import 'pages/testpage.dart';
import 'pages/copy_page.dart';
import 'package:get/get.dart';
import 'pages/login_page.dart';
import '../system/file3.dart';
import '../system/ui.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';

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
  runApp(MyApp());
}

// initState() is called when the widget is inserted into the widget tree
// initState can not be async
//but we can call an async function inside

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Used to select if we use the dark or light theme, start with system mode.
  ThemeMode themeMode = ThemeMode.system;

  // Opt in/out on Material 3
  bool useMaterial3 = true;

  @override
  Widget build(BuildContext context) {
    const FlexScheme usedScheme = FlexScheme.mandyRed;
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: FlexThemeData.light(
          scheme: usedScheme,
          // Use very subtly themed app bar elevation in light mode.
          appBarElevation: 0.5,
          // Opt in/out of using Material 3.
          useMaterial3: useMaterial3,
          // We use the nicer Material 3 Typography in both M2 and M3 mode.
          typography: Typography.material2021(platform: defaultTargetPlatform),
        ),
        darkTheme: FlexThemeData.dark(
          scheme: usedScheme,
          // Use a bit more themed elevated app bar in dark mode.
          appBarElevation: 2,
          // Opt in/out of using Material 3.
          useMaterial3: useMaterial3,
          // We use the nicer Material 3 Typography in both M2 and M3 mode.
          typography: Typography.material2021(platform: defaultTargetPlatform),
        ),
        // Use the above dark or light theme based on active themeMode.
        themeMode: themeMode,
        routes: {
          '/copy': (context) => const CopyPage(),
          '/logIn': (context) => const LogInPage(),
          '/test': (context) => const EmptyPage(),
          '/table': (context) => CustomDataTable(
              rowsPerPage: 2, colums: columnLabels, rows: rowLabels),
          "ui": (context) => SystemUI(
           // We pass it the current theme mode.
        themeMode: themeMode,
        // On the home page we can toggle theme mode between light and dark.
        onThemeModeChanged: (ThemeMode mode) {
          setState(() {
            themeMode = mode;
          });
        },
        // We pass it the current material mode.
        useMaterial3: useMaterial3,
        // On the home page we can toggle theme Material 2/3 mode.
        onUseMaterial3Changed: (bool material3) {
          setState(() {
            useMaterial3 = material3;
          });
        },
        // Pass in the FlexSchemeData we used for the active theme. Not
        // needed to use FlexColorScheme, but we use it to
        // show the active theme's name, description and colors in the
        // demo. It is also used by the theme mode switch that shows the
        // theme's colors in the different theme modes.
        flexSchemeData: FlexColor.schemes[usedScheme]!,
        )
        },
        home: SystemUI(
           // We pass it the current theme mode.
        themeMode: themeMode,
        // On the home page we can toggle theme mode between light and dark.
        onThemeModeChanged: (ThemeMode mode) {
          setState(() {
            themeMode = mode;
          });
        },
        // We pass it the current material mode.
        useMaterial3: useMaterial3,
        // On the home page we can toggle theme Material 2/3 mode.
        onUseMaterial3Changed: (bool material3) {
          setState(() {
            useMaterial3 = material3;
          });
        },
        // Pass in the FlexSchemeData we used for the active theme. Not
        // needed to use FlexColorScheme, but we use it to
        // show the active theme's name, description and colors in the
        // demo. It is also used by the theme mode switch that shows the
        // theme's colors in the different theme modes.
        flexSchemeData: FlexColor.schemes[usedScheme]!,
        ));
  }
}

import 'package:flutter/material.dart';
import 'testpage.dart';
import 'package:get/get.dart';
import 'system/utils/theme.dart';
import 'controllers/theme.dart';
import 'routes/app_screens.dart';
import 'bindings/theme.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pdf/widgets.dart' as pw;

//
import './system/utils/font_loader.dart';
//

// Global font variables
late pw.Font arabicFont;
late pw.Font arabicFontBold;
late pw.Font fallbackFont;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ar');
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ThemeController());
  Get.put(FontController());
  runApp(const MyApp());
}

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

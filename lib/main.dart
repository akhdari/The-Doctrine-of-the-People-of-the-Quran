import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'testpage.dart';
import 'package:get/get.dart';
import 'system/utils/theme.dart';
import 'controllers/theme.dart';
import 'routes/app_screens.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'bindings/starter.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  dev.log('Environment variables loaded: ${dotenv.env}');

  await initializeDateFormatting('ar');

  Get.put(ThemeController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeController.mode.value,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          initialBinding: StarterBinding(),
          getPages: AppScreens.routes,
          home: TestPage(),
        ));
  }
}

// https://rydmike.com/flexcolorscheme/themesplayground-latest/

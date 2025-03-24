import 'package:flutter/material.dart';
import 'pages/testpage.dart';
import 'pages/copy_page.dart';
import 'package:get/get.dart';
import 'pages/login_page.dart';
import '../system/file2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/copy': (context) => const CopyPage(),
        '/logIn': (context) => const LogInPage(),
        '/test': (context) => const EmptyPage(),
        '/table': (context) => TablePage(),
      },
      home: TablePage(),
    );
  }
}

import 'package:flutter/material.dart';
import 'pages/testpage.dart';
import 'pages/copy_page.dart';
import 'package:get/get.dart';
import 'pages/login_page.dart';
import '../system/file3.dart';

List<String> columnLabels = [
  'ID',
  'First Name Arabic',
  'First Name Latin',
  'Last Name Arabic',
  'Last Name Latin'
];

List<String> rowLabels = [
  //should match the data list map keys
  'id',
  'last_name',
  'first_name_arabic',
  'first_name_latin',
  'last_name_latin' //+
];
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
          '/table': (context) => CustomDataTable(
              rowsPerPage: 2, colums: columnLabels, rows: rowLabels),
        },
        home: CustomDataTable(
            rowsPerPage: 2, colums: columnLabels, rows: rowLabels));
  }
}

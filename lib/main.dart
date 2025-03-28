import 'package:flutter/material.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/file1.dart';
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
  'Last Name Latin',
  'Place of Birth',
  'Date of Birth',
  'Nationality',
  'Lecture Name',
  'User Name',
];

List<String> rowLabels = [
  //should match the data list map keys
  'id',
  'last_name',
  'first_name_arabic',
  'first_name_latin',
  'last_name_latin', //+
  'place_of_birth',
  'date_of_birth',
  'nationality',
  'lecture_name',
  'user_name'
];
void main() {
  runApp(MyApp());
}

// initState() is called when the widget is inserted into the widget tree
// initState can not be async
//but we can call an async function inside

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

import 'package:flutter/material.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/pages/testpage.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/widgets/login.dart';
//import 'login.dart';
//import 'order.dart';
//import 'form.dart';
import 'pages/copy_page.dart';
import 'package:get/get.dart';
//import 'widgets/form.dart';

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
        '/logIn': (context) => const MyWidget(),
        '/test': (context) => const EmptyPage(),
      },
      home: EmptyPage(),
    );
  }
}

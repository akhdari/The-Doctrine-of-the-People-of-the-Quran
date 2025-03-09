import 'package:flutter/material.dart';
import 'package:quran_projet/pages/page1.dart';
import 'package:quran_projet/pages/page2.dart';
import 'package:quran_projet/pages/page3.dart';


void main() {
  runApp(AhlAlQuranApp());
}

class AhlAlQuranApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Page1(),
    );
  }
}



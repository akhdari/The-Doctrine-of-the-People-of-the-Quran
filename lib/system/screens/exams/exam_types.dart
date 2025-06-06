import 'package:flutter/material.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/screens/system_ui.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/grids/exams_types/exam_show.dart';

class ExamTypes extends StatelessWidget {
  const ExamTypes({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaffoldBackgroundColor = theme.scaffoldBackgroundColor;
    return Scaffold(
        backgroundColor: scaffoldBackgroundColor,
        body:
            SystemUI(title: "Exam types Management", child: ExamTypesScreen()));
  }
}

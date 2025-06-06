import 'package:flutter/material.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/screens/base_layout.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/grids/exams_records/exam_show.dart';

class ExamRecords extends StatelessWidget {
  const ExamRecords({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaffoldBackgroundColor = theme.scaffoldBackgroundColor;
    return Scaffold(
        backgroundColor: scaffoldBackgroundColor,
        body: BaseLayout(
            title: "Exam Records Management", child: ExamRecordsScreen()));
  }
}

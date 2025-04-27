import 'package:flutter/material.dart';
import '../widgets/grids/lectures/lecture_show.dart';
import 'system_ui.dart';

class AddLecture extends StatelessWidget {
  const AddLecture({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SystemUI(
        title: "Lectures Management",
        child: LectureScreen(),
      ),
    );
  }
}

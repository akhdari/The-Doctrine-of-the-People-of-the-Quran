import 'package:flutter/material.dart';
import 'system_ui.dart';
import '../widgets/dialogs/lecture.dart';

class AddLecture extends StatelessWidget {
  const AddLecture({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SystemUI(
        dialogContent: LectureDialog(),
        buttonText: 'open lecture dialoge',
      ),
    );
  }
}

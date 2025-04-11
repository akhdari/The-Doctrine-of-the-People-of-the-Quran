import 'package:flutter/material.dart';

import './system_ui.dart';
import './student_dialog.dart';

class AddStudent extends StatelessWidget {
  const AddStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SystemUI(
        dialogContent: StudentDialog(),
        buttonText: 'open student dialoge',
      ),
    );
  }
}

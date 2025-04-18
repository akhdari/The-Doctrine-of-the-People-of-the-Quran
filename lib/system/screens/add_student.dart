import 'package:flutter/material.dart';

import 'system_ui.dart';
import '../widgets/dialogs/student.dart';

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

import 'package:flutter/material.dart';
import './system_ui.dart';
import './acheivement_dialog.dart';

class AddAcheivement extends StatelessWidget {
  const AddAcheivement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SystemUI(
        dialogContent: AcheivemtDialog(),
        buttonText: 'open guardian dialoge',
      ),
    );
  }
}

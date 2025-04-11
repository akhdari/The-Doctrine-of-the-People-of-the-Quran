import 'package:flutter/material.dart';

import './system_ui.dart';
import './guardian_dialog.dart';

class AddGuardian extends StatelessWidget {
  const AddGuardian({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SystemUI(
        dialogContent: GuardianDialog(),
        buttonText: 'open guardian dialoge',
      ),
    );
  }
}

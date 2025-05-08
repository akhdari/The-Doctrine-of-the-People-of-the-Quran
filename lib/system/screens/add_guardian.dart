import 'package:flutter/material.dart';
import '../widgets/grids/guardians/guardian_show.dart';
import 'system_ui.dart';

class AddGuardian extends StatelessWidget {
  const AddGuardian({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaffoldBackgroundColor = theme.scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: SystemUI(
        title: "Guardians Management",
        child: GuardianScreen(),
      ),
    );
  }
}

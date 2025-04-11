import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import '../widgets/end_drawer.dart';
import '../widgets/theme.dart';
import 'package:get/get.dart';

class SystemUI extends StatefulWidget {
  final Widget dialogContent;
  final String buttonText;
  const SystemUI({
    super.key,
    required this.dialogContent,
    required this.buttonText,
  });

  @override
  State<SystemUI> createState() => _SystemUIState();
}

class _SystemUIState extends State<SystemUI> {
  final GlobalKey<ScaffoldState> studentScaffoldKey =
      GlobalKey<ScaffoldState>();

  bool isClicked = false;
  late ThemeController themeController;

  @override
  void initState() {
    super.initState();

    themeController = Get.find<ThemeController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: studentScaffoldKey,
      drawerEnableOpenDragGesture: true,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => studentScaffoldKey.currentState?.openEndDrawer(),
          ),
        ],
      ),
      endDrawer: customEndDrawer(),
      body: Column(
        children: [
          IconButton(
            onPressed: () {
              isClicked = !isClicked;
              themeController.switchTheme();
              dev.log("theme changed");
            },
            icon: const Icon(Icons.nightlight_round),
          ),
          Center(
            child: OutlinedButton(
              onPressed: () => Get.dialog(widget.dialogContent),
              child: Text(widget.buttonText),
            ),
          ),
        ],
      ),
    );
  }
}

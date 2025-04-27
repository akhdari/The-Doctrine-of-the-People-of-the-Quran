import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import '../widgets/end_drawer.dart';
import 'package:get/get.dart';
import 'package:dotted_line/dotted_line.dart';
import '/controllers/theme.dart';

class SystemUI extends StatefulWidget {
  final String title;
  final Widget child;

  const SystemUI({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  State<SystemUI> createState() => _SystemUIState();
}

class _SystemUIState extends State<SystemUI> {
  final GlobalKey<ScaffoldState> systemUiScaffoldKey =
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
      key: systemUiScaffoldKey,
      drawerEnableOpenDragGesture: true,
      endDrawer: customEndDrawer(),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 160,
            color: Theme.of(context).appBarTheme.backgroundColor,
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        widget.title,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DottedLine(
                    dashColor: Theme.of(context)
                        .dividerColor, // Use theme divider color
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          isClicked = !isClicked;
                          themeController.switchTheme();
                          dev.log("theme changed");
                        },
                        icon: Icon(
                          Icons.nightlight_round,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        onPressed: () =>
                            systemUiScaffoldKey.currentState?.openEndDrawer(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: widget.child),
        ],
      ),
    );
  }
}

import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import '../widgets/end_drawer.dart';
import 'package:get/get.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/controllers/theme.dart';
import '../widgets/image.dart';
import '../../system/widgets/lunch_url.dart';

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
    final theme = Theme.of(context);
    final appBarTheme = theme.appBarTheme;
    final textTheme = theme.textTheme;
    final iconTheme = theme.iconTheme;
    final scaffoldBackgroundColor = theme.scaffoldBackgroundColor;
    final dividerColor = theme.dividerColor;

    return Scaffold(
      key: systemUiScaffoldKey,
      backgroundColor: scaffoldBackgroundColor,
      endDrawer: CustomEndDrawer(),
      drawerEnableOpenDragGesture: true,
      body: Column(
        children: [
          Container(
            color: appBarTheme.backgroundColor,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomImage(imagePath: "assets/logo.png", height: 50),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        widget.title,
                        textAlign: TextAlign.center,
                        style: textTheme.titleLarge,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Wrap(
                      spacing: 10,
                      children: [
                        GestureDetector(
                            onTap: () => launchURL(
                                'https://apps.apple.com/us/app/example-app/id123456789'),
                            child: SvgPicture.asset(
                              'assets/appstore.svg',
                              height: 50,
                              width: 120,
                            )),
                        GestureDetector(
                          onTap: () => launchURL(
                              'https://play.google.com/store/apps/details?id=com.example.app'),
                          child: CustomImage(
                              imagePath: 'assets/googleplay.png', height: 50),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                DottedLine(
                  dashColor: dividerColor,
                ),
                const SizedBox(height: 8),
                Row(
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
                        color: iconTheme.color,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: iconTheme.color,
                      ),
                      onPressed: () =>
                          systemUiScaffoldKey.currentState?.openEndDrawer(),
                    ),
                  ],
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

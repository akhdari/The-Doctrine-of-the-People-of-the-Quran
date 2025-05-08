import 'package:flutter/material.dart';

class CustomEndDrawer extends StatelessWidget {
  const CustomEndDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return Drawer(
      //top level widget
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: colorScheme.primary),
            child: Text(
              "hello",
              style: textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
          ListTile(
            title: Text(
              "لوجه القيادة",
              style: textTheme.titleLarge,
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text("الرسائل", style: textTheme.titleSmall),
            onTap: () {},
          ),
          ListTile(
            title: Text(" الوعودات", style: textTheme.titleSmall),
            onTap: () {},
          ),
          ListTile(
            title: Text("الشؤون الإدارية", style: textTheme.titleSmall),
            onTap: () {},
          ),
          ListTile(
            title: Text("الطلاب", style: textTheme.titleSmall),
            onTap: () {},
          ),
          ListTile(
            title: Text("الأساتذة", style: textTheme.titleSmall),
            onTap: () {},
          ),
          ListTile(
            title: Text(" الحصص", style: textTheme.titleSmall),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

Drawer customEndDrawer() {
  return Drawer(
      //top level widget
      child: ListView(
    padding: EdgeInsets.zero,
    children: [
      DrawerHeader(
        decoration: BoxDecoration(color: Color(0xFF0E9D6D)),
        child: Text(
          "hello",
          style: TextStyle(),
          textAlign: TextAlign.center,
        ),
      ),
      ListTile(
        title: Text(
          "لوجه القيادة",
          style: TextStyle(color: Color(0xFF0E9D6D)),
        ),
        onTap: () {},
      ),
      ListTile(
        title: Text("الرسائل"),
        onTap: () {},
      ),
      ListTile(
        title: Text(" الوعودات"),
        onTap: () {},
      ),
      ListTile(
        title: Text("الشؤون الإدارية"),
        onTap: () {},
      ),
      ListTile(
        title: Text("الطلاب"),
        onTap: () {},
      ),
      ListTile(
        title: Text("الأساتذة"),
        onTap: () {},
      ),
      ListTile(
        title: Text(" الحصص"),
        onTap: () {},
      ),
    ],
  ));
}

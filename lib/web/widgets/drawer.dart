import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF0E9D6D)),
            child: Text(
              'القائمة',
              style: TextStyle(
                  color: Colors.white, fontSize: 34, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          _drawerItem('الرئيسية'),
          _drawerItem('الأسعار'),
          _drawerItem('المزايا'),
          _drawerItem('الدعم الفني'),
          _drawerItem('التسويق بالعمولة'),
          _drawerItem('تسجيل الدخول'),
        ],
      ),
    );
  }

  Widget _drawerItem(String title) {
    return ListTile(title: Text(title), onTap: () {});
  }
}

import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const NavBar({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isLargeScreen = constraints.maxWidth > 800;

        return isLargeScreen
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _navItems(),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(Icons.menu, color: Colors.white),
                    onPressed: () {
                      scaffoldKey.currentState?.openDrawer();
                    },
                  ),
                ),
              );
      },
    );
  }

  List<Widget> _navItems() {
    List<String> titles = [
      'الرئيسية',
      'الأسعار',
      'المزايا',
      'الدعم الفني',
      'التسويق بالعمولة',
      'تسجيل الدخول'
    ];

    return titles.map((title) {
      return TextButton(
        onPressed: () {},
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            
            fontWeight: title == 'تسجيل الدخول' ? FontWeight.w900 : FontWeight.w600,
            fontSize: 18,
          ),
        ),
      );
    }).toList();
  }
}

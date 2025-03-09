import 'package:flutter/material.dart';
import 'nav.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String? page; // Page parameter for customization

  const CustomAppBar({
    Key? key,
    required this.scaffoldKey,
    this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavBar(scaffoldKey: scaffoldKey);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // AppBar standard height
}


import 'package:flutter/material.dart';
import 'custom_nav_bar.dart';
//import 'form.dart';

class Link extends StatelessWidget {
  Link({super.key});
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(scaffoldKey: scaffoldKey),
     // body: page that needs to be linked,
    );
  }
}

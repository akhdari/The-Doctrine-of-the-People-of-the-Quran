import 'package:flutter/material.dart';
import 'package:quran_projet/nav.dart';
import 'package:quran_projet/widgetsweb/Footer.dart';
import 'package:quran_projet/widgetsweb/appbar.dart';
import 'package:quran_projet/widgetsweb/features_section.dart';
import 'package:quran_projet/widgetsweb/section3.dart';

class Page3 extends StatefulWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          Container(color: Color(0xFF0E9D6D)),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/back.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.2), BlendMode.dstIn),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                color: Color(0xFF0E9D6D),
                padding: EdgeInsets.symmetric(vertical: 10),
                child: NavBar(scaffoldKey: _scaffoldKey),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 50),
                      _textContent(),
                      SizedBox(height: 50),
                      FeaturesSection(),
                      Section3(),
                      FooterSection()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _textContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'خصائص النظام',
          style: TextStyle(
              fontSize: 52, color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Text(
          'خصائص النظام/الرئيسية',
          style: TextStyle(
              fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
      ],
    );
  }
}

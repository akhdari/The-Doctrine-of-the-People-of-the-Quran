import 'package:flutter/material.dart';
import 'package:quran_projet/nav.dart';
import 'package:quran_projet/widgetsweb/ContactForm.dart';
import 'package:quran_projet/widgetsweb/Footer.dart';
import 'package:quran_projet/widgetsweb/PartnersSection.dart';
import 'package:quran_projet/widgetsweb/SubscriptionSection.dart';
import 'package:quran_projet/widgetsweb/appbar.dart';
import 'package:quran_projet/widgetsweb/custom_app_section.dart';
import 'package:quran_projet/widgetsweb/features_section.dart';
import 'package:quran_projet/widgetsweb/image3scrol.dart';
import 'package:quran_projet/widgetsweb/mobile_showcase.dart';
import 'package:quran_projet/widgetsweb/nutifForm.dart';
import 'package:quran_projet/widgetsweb/pricing_section.dart';
import 'package:quran_projet/widgetsweb/section3.dart';
import 'package:quran_projet/widgetsweb/section6.dart';
import 'package:quran_projet/widgetsweb/users_section.dart';
import 'package:quran_projet/widgetsweb/image_carousel.dart';
import 'package:quran_projet/widgetsweb/stats_section.dart';

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isHoveredImage = false;
  bool isHoveredButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(), // Utilisation du fichier séparé pour le menu
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
              // Barre de navigation fixe
              Container(
                color: Color(0xFF0E9D6D),
                padding: EdgeInsets.symmetric(vertical: 10),
                child: NavBar(scaffoldKey: _scaffoldKey),
              ),
              // Contenu principal
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(height: 120),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          bool isLargeScreen = constraints.maxWidth > 800;
                          return isLargeScreen
                              ? _largeScreenContent()
                              : _smallScreenContent();
                        },
                      ),
                      SizedBox(height: 80),
                      FeaturesSection(),
                      SizedBox(height: 50),
                      UsersSection(),
                      SizedBox(height: 50),
                      Section3(),
                      SizedBox(height: 50),
                      _carouselSection(),
                      SizedBox(height: 50),
                      MobileShowcase(),
                      SizedBox(height: 50),
                      PricingSection(),
                      Section6(),
                      CustomAppSection(),
                      StatsSection(),
                      ImageCarousel3(),
                      PartnersSection(),
                      SubscriptionSection(),
                      ContactForm(),
                      NutifForm(),
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

  Widget _largeScreenContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: MouseRegion(
            onEnter: (_) => setState(() => isHoveredImage = true),
            onExit: (_) => setState(() => isHoveredImage = false),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              transform: isHoveredImage
                  ? Matrix4.translationValues(0, -10, 0)
                  : Matrix4.identity(),
              child: Image.asset('assets/homme.png',
                  fit: BoxFit.contain, height: 350),
            ),
          ),
        ),
        SizedBox(width: 20),
        Expanded(child: _textContent()),
      ],
    );
  }

  Widget _smallScreenContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _textContent(),
        SizedBox(height: 40),
        MouseRegion(
          onEnter: (_) => setState(() => isHoveredImage = true),
          onExit: (_) => setState(() => isHoveredImage = false),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            transform: isHoveredImage
                ? Matrix4.translationValues(0, -10, 0)
                : Matrix4.identity(),
            child: Image.asset('assets/homme.png',
                fit: BoxFit.contain, height: 250),
          ),
        ),
      ],
    );
  }

  Widget _textContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('نظام أهل القرآن',
            style: TextStyle(
                fontSize: 52, color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
        Text('تسيير وتيسير التعليم القرآني',
            style: TextStyle(
                fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
        SizedBox(height: 20),
        Text(
            '.نظام أهل القرآن هو نظام سحابي متكامل .. يمكن بواسطته إنشاء بيئة رقمية',
            style: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
        Text(
            ' تربط بين مشرفي الحلقات ومدرسيها وطلابها وأولياء الأمور ، وذلك بمنحهم الأدوات الحديثة للارتقاء بحلقات القرآن',
            style: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
        SizedBox(height: 25),
        MouseRegion(
          onEnter: (_) => setState(() => isHoveredButton = true),
          onExit: (_) => setState(() => isHoveredButton = false),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: isHoveredButton ? Colors.white : Colors.orange,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.orange, width: 2),
            ),
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
            child: Text(
              'طلب نسخة',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isHoveredButton ? Colors.orange : Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _carouselSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ImageCarousel(),
    );
  }
}

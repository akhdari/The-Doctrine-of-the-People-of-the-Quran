import 'package:flutter/material.dart';
import 'package:quran_projet/nav.dart';
import 'package:quran_projet/widgets/custom_app_section.dart';
import 'package:quran_projet/widgets/features_section.dart';
import 'package:quran_projet/widgets/mobile_showcase.dart';
import 'package:quran_projet/widgets/pricing_section.dart';
import 'package:quran_projet/widgets/section3.dart';
import 'package:quran_projet/widgets/section6.dart';
import 'package:quran_projet/widgets/user_card.dart';
import 'package:quran_projet/widgets/image_carousel.dart';
import 'package:quran_projet/widgets/users_section.dart';



class Page1 extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
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
      ),
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
              // Contenu avec espace pour éviter le chevauchement
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(height: 120), // Ajuste l'espacement
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
}

  Widget _largeScreenContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Image.asset('assets/homme.png', fit: BoxFit.contain, height: 350),
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
        Image.asset('assets/homme.png', fit: BoxFit.contain, height: 250),
      ],
    );
  }

  Widget _textContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('نظام أهل القرآن', style: TextStyle(fontSize: 52, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
        Text('تسيير وتيسير التعليم القرآني', style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
        SizedBox(height: 20),
        Text('.نظام أهل القرآن هو نظام سحابي متكامل .. يمكن بواسطته إنشاء بيئة رقمية', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
         Text(' تربط بين مشرفي الحلقات ومدرسيها وطلابها وأولياء الأمور ، وذلك بمنحهم الأدوات الحديثة للارتقاء بحلقات القرآن', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
        SizedBox(height: 25),
        ElevatedButton(
          onPressed: () {},
          child: Text('طلب نسخة', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
            textStyle: TextStyle(fontSize: 18),
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
 
  Widget _drawerItem(String title) {
    return ListTile(title: Text(title), onTap: () {});
  }


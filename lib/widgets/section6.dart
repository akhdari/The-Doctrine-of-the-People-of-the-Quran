import 'package:flutter/material.dart';
import 'zoom.dart'; // Assure-toi que le chemin est correct selon ton projet

class Section6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // Fond blanc
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
      child: Column(
        children: [
          Text(
            "الخدمات الإضافية",
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount;
              double aspectRatio;

              if (constraints.maxWidth > 800) {
                crossAxisCount = 4;
                aspectRatio = 0.8; // Grand écran, cartes plus larges
              } else if (constraints.maxWidth > 600) {
                crossAxisCount = 2;
                aspectRatio = 0.9; // Taille moyenne, cartes un peu plus petites
              } else {
                crossAxisCount = 1;
                aspectRatio = 1.2; // Petit écran, cartes plus compactes
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 20, // Ajusté pour garder un bon alignement
                  mainAxisSpacing: 15,
                  childAspectRatio: aspectRatio,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  List<Map<String, dynamic>> cards = [
                    {
                      "title": "الموقع التعريفي",
                      "price": "19900",
                      "description": "التسجيل الإلكتروني\nمكتبة المدرسة\nأنشطة وأخبار المدرسة",
                      "icon": Icons.web
                    },
                    {
                      "title": "الشؤون المالية",
                      "price": "19900",
                      "description": "اشتراكات الطلب\nرواتب المعلمين والموظفين\nإدارة المدخلات والمصاريف",
                      "icon": Icons.attach_money
                    },
                    {
                      "title": "الرسائل الخاصة",
                      "price": "9900",
                      "description": "التواصل بين الجميع\nخاصة وجماعية\nتنبيهات فورية",
                      "icon": Icons.message
                    },
                    {
                      "title": "المقرأة الإلكترونية",
                      "price": "9900",
                      "description": "حلقات افتراضية\nوقت غير محدود\nغرف فردية وجماعية",
                      "icon": Icons.video_call
                    }
                  ];

                  return ZoomCard(
                    title: cards[index]["title"],
                    price: cards[index]["price"],
                    description: cards[index]["description"],
                    icon: cards[index]["icon"],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Section6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
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
                aspectRatio = 0.8;
              } else if (constraints.maxWidth > 600) {
                crossAxisCount = 2;
                aspectRatio = 0.9;
              } else {
                crossAxisCount = 1;
                aspectRatio = 1.5;
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 15,
                  childAspectRatio: aspectRatio,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  List<Map<String, dynamic>> cards = [
                    {
                      "title": "الشؤون المالية",
                      "price": "DA19900",
                      "description": [
                        "اشتراكات الطلاب",
                        "رواتب المعلمين والموظفين",
                        "إدارة المداخيل والمصاريف",
                      ],
                      "icon": Icons.attach_money
                    },
                    {
                      "title": "الموقع التعريفي",
                      "price": "DA19900",
                      "description": [
                        "التسجيل الإلكتروني",
                        "مكتبة المدرسة",
                        "أنشطة وأخبار المدرسة",
                      ],
                      "icon": Icons.web
                    },
                    {
                      "title": "الرسائل الخاصة",
                      "price": "DA9900",
                      "description": [
                        "التواصل بين الجميع",
                        "خاصة وجماعية",
                        "تنبيهات فورية",
                      ],
                      "icon": Icons.message
                    },
                    {
                      "title": "المقرأة الإلكترونية",
                      "price": "DA9900",
                      "description": [
                        "حلقات افتراضية",
                        "وقت غير محدود",
                        "غرف فردية وجماعية",
                      ],
                      "icon": Icons.video_call
                    }
                  ];

                  return AnimatedZoomCard(
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

class AnimatedZoomCard extends StatefulWidget {
  final String title;
  final String price;
  final List<String> description;
  final IconData icon;

  const AnimatedZoomCard({
    required this.title,
    required this.price,
    required this.description,
    required this.icon,
  });

  @override
  _AnimatedZoomCardState createState() => _AnimatedZoomCardState();
}

class _AnimatedZoomCardState extends State<AnimatedZoomCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        transform: isHovered ? Matrix4.translationValues(0, -5, 0) : Matrix4.identity(),
        decoration: BoxDecoration(
          color: Color(0xFF0E9D6D), // Couleur verte pour la carte
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: isHovered ? 12 : 6,
              offset: Offset(0, isHovered ? 4 : 2),
            )
          ],
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.icon, size: 50, color: Colors.white),
            SizedBox(height: 10),
            Text(
              widget.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                widget.price,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.teal),
              ),
            ),
            SizedBox(height: 10),
            Column(
              children: widget.description.map((text) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

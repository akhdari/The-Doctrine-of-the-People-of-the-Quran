import 'package:flutter/material.dart';

class Section6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
      child: Column(
        children: [
          // Title text
          const Text(
            "الخدمات الإضافية",
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          // Responsive grid using LayoutBuilder
          LayoutBuilder(
            builder: (context, constraints) {
              // Determine grid layout based on width
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

              // Card data
              final List<Map<String, dynamic>> cards = [
                {
                  "title": "الشؤون المالية",
                  "price": "DA19900",
                  "description": [
                    "اشتراكات الطلاب",
                    "رواتب المعلمين والموظفين",
                    "إدارة المداخيل والمصاريف",
                  ],
                  "icon": Icons.attach_money,
                },
                {
                  "title": "الموقع التعريفي",
                  "price": "DA19900",
                  "description": [
                    "التسجيل الإلكتروني",
                    "مكتبة المدرسة",
                    "أنشطة وأخبار المدرسة",
                  ],
                  "icon": Icons.web,
                },
                {
                  "title": "الرسائل الخاصة",
                  "price": "DA9900",
                  "description": [
                    "التواصل بين الجميع",
                    "خاصة وجماعية",
                    "تنبيهات فورية",
                  ],
                  "icon": Icons.message,
                },
                {
                  "title": "المقرأة الإلكترونية",
                  "price": "DA9900",
                  "description": [
                    "حلقات افتراضية",
                    "وقت غير محدود",
                    "غرف فردية وجماعية",
                  ],
                  "icon": Icons.video_call,
                },
              ];

              // GridView builder for cards
              return GridView.builder(
                shrinkWrap: true, // Prevent GridView from expanding infinitely
                physics:
                    NeverScrollableScrollPhysics(), // Disable internal scrolling
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 15,
                  childAspectRatio: aspectRatio,
                ),
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  final card = cards[index];
                  return AnimatedZoomCard(
                    title: card["title"],
                    price: card["price"],
                    description: List<String>.from(card["description"]),
                    icon: card["icon"],
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

// Card widget with zoom animation on hover (for web/desktop)
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
  bool isHovered = false; // Track hover state

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true), // Hover starts
      onExit: (_) => setState(() => isHovered = false), // Hover ends
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        transform: isHovered
            ? Matrix4.translationValues(0, -5, 0)
            : Matrix4.identity(), // Move card up on hover
        decoration: BoxDecoration(
          color: Color(0xFF0E9D6D), // Green card background
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: isHovered ? 12 : 6, // Stronger shadow on hover
              offset: Offset(0, isHovered ? 4 : 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.icon, size: 50, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                widget.price,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ),
            const SizedBox(height: 10),
            // List of description items
            Column(
              children: widget.description
                  .map(
                    (text) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

/// Section6 displays a responsive grid of service cards with app theme and Cairo font.
class Section6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
      child: Column(
        children: [
          // Section title using theme text style
          Text(
            "الخدمات الإضافية",
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          // Responsive grid for cards
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

              final List<Map<String, dynamic>> cards = [
                {
                  "title": "الشؤون المالية",
                  "price": "دج 19900",
                  "description": [
                    "اشتراكات الطلاب",
                    "رواتب المعلمين والموظفين",
                    "إدارة المداخيل والمصاريف",
                  ],
                  "icon": Icons.attach_money,
                },
                {
                  "title": "الموقع التعريفي",
                  "price": "دج 19900",
                  "description": [
                    "التسجيل الإلكتروني",
                    "مكتبة المدرسة",
                    "أنشطة وأخبار المدرسة",
                  ],
                  "icon": Icons.web,
                },
                {
                  "title": "الرسائل الخاصة",
                  "price": "دج 9900",
                  "description": [
                    "التواصل بين الجميع",
                    "رسائل خاصة وجماعية",
                    "تنبيهات فورية",
                  ],
                  "icon": Icons.message,
                },
                {
                  "title": "المقرأة الإلكترونية",
                  "price": "دج 9900",
                  "description": [
                    "حلقات افتراضية",
                    "وقت غير محدود",
                    "غرف فردية وجماعية",
                  ],
                  "icon": Icons.video_call,
                },
              ];

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
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

/// Card widget with zoom effect on hover (for web/desktop).
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
        duration: const Duration(milliseconds: 200),
        transform: isHovered
            ? Matrix4.translationValues(0, -5, 0)
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: isHovered ? 12 : 6,
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
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
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
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: widget.description
                  .map(
                    (text) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        text,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                            ),
                        textAlign: TextAlign.center,
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

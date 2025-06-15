import 'package:flutter/material.dart';

class CustomAppSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // Fond blanc
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20), // Espace autour
      child: Column(
        children: [
          Text(
            "التطبيق المخصص",
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            "يمكنك الحصول على تطبيق خاص بالمدرسة أو المؤسسة وفق هوية المدرسة.",
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),

          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = constraints.maxWidth > 800 ? 3 : 1; // 3 cartes sur grand écran, 1 sur mobile

              return GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 25, // Espacement entre les colonnes
                mainAxisSpacing: 20,
                childAspectRatio: 1.7, // Ajustement du ratio pour un bon rendu
                children: [
                  PricingCard(title: "تطبيق IOS و ANDROID", price: "49900",color: Color(0xFF0E9D6D)),
                  PricingCard(title: "تطبيق IOS", price: "29900",  color: Color(0xFF0E9D6D)),
                  PricingCard(title: "تطبيق ANDROID", price: "29900",color: Color(0xFF0E9D6D)),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class PricingCard extends StatefulWidget {
  final String title;
  final String price;
  final Color color;

  PricingCard({required this.title, required this.price, required this.color});

  @override
  _PricingCardState createState() => _PricingCardState();
}

class _PricingCardState extends State<PricingCard> {
  double elevation = 0;
  double translateY = 0;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          elevation = 8;  // Ajoute une ombre
          translateY = -5; // Monte de 5 pixels
        });
      },
      onExit: (_) {
        setState(() {
          elevation = 0;
          translateY = 0;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, translateY, 0),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: elevation, 
              offset: Offset(0, elevation / 2),
            ),
          ],
        ),
        padding: EdgeInsets.all(12),
        child: Center( // Centrer le contenu verticalement et horizontalement
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Alignement vertical
            children: [
              Text(
                widget.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20), // Espacement entre le titre et le prix
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      "DA ${widget.price}",
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    Text(
                      "سنوياً",
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

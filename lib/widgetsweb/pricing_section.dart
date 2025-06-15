import 'package:flutter/material.dart';

class PricingSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Titre
          Text(
            'عروض النّظام الأساسية',
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5),
          Divider(
            color: Colors.green,
            thickness: 2,
            indent: 80,
            endIndent: 80,
          ),
          SizedBox(height: 20),

          // Grille responsive
          GridView.count(
            crossAxisCount: MediaQuery.of(context).size.width > 800 ? 3 : 1,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 0.7, // Ajusté pour tenir compte de la nouvelle taille de l'image
            children: [
              HoverPricingCard(
                title: 'المدرسة الكبيرة',
                subtitle: 'أكثر من 1000 طالب',
                imagePath: 'assets/school2.png',
                schoolPrice: 'اشتراك المدرسة سنويا / DA 79900',
                studentPrice: 'اشتراك الطالب مدى الحياة / DA 100',
              ),
              HoverPricingCard(
                title: 'المدرسة المتوسطة',
                subtitle: '500 إلى 1000 طالب',
                imagePath: 'assets/school2.png',
                schoolPrice: 'اشتراك المدرسة سنويا / DA 49900',
                studentPrice: 'اشتراك الطالب مدى الحياة / DA 200',
              ),
              HoverPricingCard(
                title: 'المدرسة الصغيرة',
                subtitle: 'أقل من 500 طالب',
                imagePath: 'assets/school2.png',
                schoolPrice: 'اشتراك المدرسة سنويا / DA 29900',
                studentPrice: 'اشتراك الطالب مدى الحياة / DA 300',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Widget avec animation au survol
class HoverPricingCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final String schoolPrice;
  final String studentPrice;

  const HoverPricingCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.schoolPrice,
    required this.studentPrice,
  }) : super(key: key);

  @override
  _HoverPricingCardState createState() => _HoverPricingCardState();
}

class _HoverPricingCardState extends State<HoverPricingCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        transform: _isHovered ? Matrix4.translationValues(0, -5, 0) : Matrix4.identity(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: _isHovered
              ? [BoxShadow(color: Colors.black26, blurRadius: 8, spreadRadius: 2, offset: Offset(0, 4))]
              : [],
        ),
        child: _buildPricingCard(
          title: widget.title,
          subtitle: widget.subtitle,
          imagePath: widget.imagePath,
          schoolPrice: widget.schoolPrice,
          studentPrice: widget.studentPrice,
        ),
      ),
    );
  }

  // Widget qui construit une carte “offre”
  Widget _buildPricingCard({
    required String title,
    required String subtitle,
    required String imagePath,
    required String schoolPrice,
    required String studentPrice,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Partie verte avec le titre et le sous-titre
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Color(0xFF0E9D6D),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Image agrandie
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Image.asset(imagePath, height: 280, fit: BoxFit.contain),
          ),

          // Prix
          Text(
            schoolPrice,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(
            studentPrice,
            style: TextStyle(fontSize: 16, color: Colors.black54),
            textAlign: TextAlign.center,
          ),

          // Bouton
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Action du bouton
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
            ),
            child: Text(
              'طلب نسخة',
              style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

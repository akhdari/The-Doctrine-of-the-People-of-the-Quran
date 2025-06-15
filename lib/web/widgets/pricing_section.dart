import 'package:flutter/material.dart';

class PricingSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      color: colorScheme.onSurface, // Use theme background
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'عروض النّظام الأساسية',
            style: textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface, // Use theme onBackground
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Divider(
            color: colorScheme.primary,
            thickness: 2,
            indent: 80,
            endIndent: 80,
          ),
          const SizedBox(height: 20),
          GridView.count(
            crossAxisCount: MediaQuery.of(context).size.width > 800 ? 3 : 1,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 0.7,
            children: const [
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
        duration: const Duration(milliseconds: 200),
        transform: _isHovered
            ? Matrix4.translationValues(0, -5, 0)
            : Matrix4.identity(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  )
                ]
              : [],
        ),
        child: _buildPricingCard(context),
      ),
    );
  }

  Widget _buildPricingCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.08), // Use theme shadow
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Column(
              children: [
                Text(
                  widget.title,
                  style: textTheme.titleLarge?.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  widget.subtitle,
                  style: textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onPrimary.withOpacity(0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Image.asset(
              widget.imagePath,
              height: 280,
              fit: BoxFit.contain,
            ),
          ),
          Text(
            widget.schoolPrice,
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface, // Use theme onSurface
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            widget.studentPrice,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // TODO: handle button action
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.secondary,
              foregroundColor: colorScheme.onSecondary, // Use theme onSecondary
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
              textStyle: textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            child: Text(
              'طلب نسخة',
              style: textTheme.labelLarge?.copyWith(
                color: colorScheme.onSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

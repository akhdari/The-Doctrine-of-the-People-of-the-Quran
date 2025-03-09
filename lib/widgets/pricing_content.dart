import 'package:flutter/material.dart';

class PricingContent extends StatelessWidget {
  const PricingContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Prend toute la largeur de l'écran
      color: Colors.white, // Fond blanc
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'نظام أهل القرآن سوف يغنيك عن الكثير من الأدوات ويختصرها في مكان واحد.\n'
              'ويمكنك من الارتقاء بمدرستك باستعماله فخر تقنيات التسيير والإدارة والتعليم\n'
              'بالإضافة لذلك فإن استخدامك له سيساهم في عدة مشاريع تخدم القرآن الكريم',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.black87),
            ),
            const SizedBox(height: 30),
            const Text(
              'أنواع الاشتراكات',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 3,
              width: 60,
              color: const Color(0xFF0E9D6D),
            ),
            const SizedBox(height: 30),
            _subscriptionText(
              title: 'اشتراك المدرسة (اشتراك سنوي)',
              description:
                  'هو الاشتراك الذي يتم من خلاله إعطاء لوحة تحكم خاصة بمدير المدرسة لإدارة جميع عمليات النظام.',
              titleColor: Colors.orange,
            ),
            const SizedBox(height: 20),
            _subscriptionText(
              title: 'اشتراك الطالب (اشتراك دائم)',
              description:
                  'هو الاشتراك الذي يمكن للطالب من الاستفادة من جميع مزايا النظام عن طريق إنشاء حساب خاص به لمتابعة دروسه وتخرجه من المدرسة.',
              titleColor: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  static Widget _subscriptionText({
    required String title,
    required String description,
    required Color titleColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: titleColor,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          description,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

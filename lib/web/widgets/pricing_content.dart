import 'package:flutter/material.dart';

class PricingContent extends StatelessWidget {
  const PricingContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      color: theme.colorScheme.onSurface,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'نظام أهل القرآن سوف يغنيك عن الكثير من الأدوات ويختصرها في مكان واحد.\n'
              'ويمكنك من الارتقاء بمدرستك باستعماله فخر تقنيات التسيير والإدارة والتعليم\n'
              'بالإضافة لذلك فإن استخدامك له سيساهم في عدة مشاريع تخدم القرآن الكريم',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge
                  ?.copyWith(color: theme.colorScheme.onBackground),
            ),
            const SizedBox(height: 30),
            Text(
              'أنواع الاشتراكات',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary, // Use theme color
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 3,
              width: 60,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 30),
            _subscriptionText(
              context: context,
              title: 'اشتراك المدرسة (اشتراك سنوي)',
              description:
                  'هو الاشتراك الذي يتم من خلاله إعطاء لوحة تحكم خاصة بمدير المدرسة لإدارة جميع عمليات النظام.',
              titleColor: theme.colorScheme.primary, // Use theme color
            ),
            const SizedBox(height: 20),
            _subscriptionText(
              context: context,
              title: 'اشتراك الطالب (اشتراك دائم)',
              description:
                  'هو الاشتراك الذي يمكن للطالب من الاستفادة من جميع مزايا النظام عن طريق إنشاء حساب خاص به لمتابعة دروسه وتخرجه من المدرسة.',
              titleColor: theme.colorScheme.secondary, // Use theme color
            ),
          ],
        ),
      ),
    );
  }

  static Widget _subscriptionText({
    required BuildContext context,
    required String title,
    required String description,
    required Color titleColor,
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: titleColor,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          description,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

/// A section encouraging subscription with a call-to-action button and message.
class SubscriptionSection extends StatelessWidget {
  const SubscriptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: _Dimensions.verticalPadding,
        horizontal: _Dimensions.horizontalPadding,
      ),
      color: _Colors.background,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              // ignore: avoid_print
              print('Subscribe Now button clicked!');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _Colors.buttonBackground,
              padding: const EdgeInsets.symmetric(
                horizontal: _Dimensions.buttonHorizontalPadding,
                vertical: _Dimensions.buttonVerticalPadding,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(_Dimensions.borderRadius),
              ),
            ),
            child: const Text(
              'الاشتراك الآن', // Subscribe Now
              style: TextStyle(
                fontSize: _TextSizes.button,
                fontWeight: FontWeight.bold,
                color: _Colors.text,
              ),
            ),
          ),
          const SizedBox(width: _Dimensions.spacing),
          const Expanded(
            child: Text(
              'لديكم مدرسة قرآنية؟ لا تتردد واطلب نسختك الآن!', // Have a Quranic school? Don’t hesitate, request your copy now!
              style: TextStyle(
                fontSize: _TextSizes.message,
                fontWeight: FontWeight.bold,
                color: _Colors.text,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

/// Constants for dimensions and styling
class _Dimensions {
  static const double verticalPadding = 60.0;
  static const double horizontalPadding = 20.0;
  static const double spacing = 20.0;
  static const double buttonHorizontalPadding = 25.0;
  static const double buttonVerticalPadding = 12.0;
  static const double borderRadius = 8.0;
}

/// Constants for colors
class _Colors {
  static const Color background = Color(0xFF0E9D6D);
  static const Color buttonBackground = Color(0xFFC78532);
  static const Color text = Colors.white;
}

/// Constants for text sizes
class _TextSizes {
  static const double message = 20.0;
  static const double button = 16.0;
}

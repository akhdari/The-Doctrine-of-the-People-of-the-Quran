import 'package:flutter/material.dart';

/// A card widget displaying a user's image and title, used within a hoverable container.
class UserCard extends StatelessWidget {
  final String imagePath;
  final String title;

  const UserCard({
    required this.imagePath,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: _CardStyles.elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_CardStyles.borderRadius),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(_CardStyles.imagePadding),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.error_outline,
                  size: _CardStyles.iconSize,
                  color: _CardStyles.errorColor,
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: _CardStyles.textPadding),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: _TextSizes.title,
                fontWeight: FontWeight.bold,
                color: _CardStyles.textColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

/// Constants for card styling
class _CardStyles {
  static const double elevation = 4.0;
  static const double borderRadius = 12.0;
  static const double imagePadding = 8.0;
  static const double textPadding = 8.0;
  static const double iconSize = 40.0;
  static const Color textColor = Colors.black;
  static const Color errorColor = Colors.red;
}

/// Constants for text sizes
class _TextSizes {
  static const double title = 18.0;
}

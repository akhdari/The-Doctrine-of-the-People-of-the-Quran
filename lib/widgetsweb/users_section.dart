import 'package:flutter/material.dart';

import 'user_card.dart'; // Ensure this file exists and is properly structured

/// A section displaying a grid of user cards with hover effects, showcasing system users.
class UsersSection extends StatelessWidget {
  const UsersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: _Dimensions.verticalPadding,
        horizontal: _Dimensions.horizontalPadding,
      ),
      child: Column(
        children: [
          const Text(
            'مستخدمو النظام', // System Users
            style: TextStyle(
              fontSize: _TextSizes.sectionTitle,
              fontWeight: FontWeight.bold,
              color: _Colors.text,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: _Dimensions.spacingSmall),
          const Text(
            'يوفر النظام خدمات ومزايا عديدة لمختلف مستخدميه.', // The system provides various services and benefits to its users
            style: TextStyle(
              fontSize: _TextSizes.sectionDescription,
              color: _Colors.text,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: _Dimensions.spacing),
          GridView.count(
            crossAxisCount: _getCrossAxisCount(context),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: _Dimensions.gridSpacing,
            mainAxisSpacing: _Dimensions.gridSpacing,
            children: const [
              HoverUserCard(
                imagePath: _AssetPaths.parent,
                title: 'ولي الأمر', // Parent
              ),
              HoverUserCard(
                imagePath: _AssetPaths.student,
                title: 'الطالب', // Student
              ),
              HoverUserCard(
                imagePath: _AssetPaths.teacher,
                title: 'المعلم', // Teacher
              ),
              HoverUserCard(
                imagePath: _AssetPaths.admin,
                title: 'المشرف', // Admin
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Determines the number of columns based on screen width.
  int _getCrossAxisCount(BuildContext context) {
    return MediaQuery.of(context).size.width > _Dimensions.breakpoint ? 4 : 1;
  }
}

/// A card widget that elevates slightly on hover, wrapping a UserCard.
class HoverUserCard extends StatefulWidget {
  final String imagePath;
  final String title;

  const HoverUserCard({
    required this.imagePath,
    required this.title,
    super.key,
  });

  @override
  HoverUserCardState createState() => HoverUserCardState();
}

class HoverUserCardState extends State<HoverUserCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true), // Elevate on hover
      onExit: (_) => setState(() => _isHovered = false), // Reset on exit
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: _isHovered
            ? Matrix4.translationValues(0, -_Dimensions.hoverElevation, 0)
            : Matrix4.identity(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_Dimensions.borderRadius),
          boxShadow: _isHovered ? [_HoverStyles.boxShadow] : [],
        ),
        child: UserCard(
          imagePath: widget.imagePath,
          title: widget.title,
        ),
      ),
    );
  }
}

/// Constants for dimensions and styling
class _Dimensions {
  static const double verticalPadding = 50.0;
  static const double horizontalPadding = 20.0;
  static const double spacing = 20.0;
  static const double spacingSmall = 8.0;
  static const double gridSpacing = 20.0;
  static const double breakpoint = 800.0;
  static const double borderRadius = 10.0;
  static const double hoverElevation = 5.0;
}

/// Constants for colors
class _Colors {
  static const Color text = Colors.white;
}

/// Constants for text sizes
class _TextSizes {
  static const double sectionTitle = 35.0;
  static const double sectionDescription = 16.0;
}

/// Constants for asset paths
class _AssetPaths {
  static const String parent = 'assets/images1/parent.png';
  static const String student = 'assets/images1/student.png';
  static const String teacher = 'assets/images1/teacher.png';
  static const String admin = 'assets/images1/admin.png';
}

/// Constants for hover styles
class _HoverStyles {
  static const BoxShadow boxShadow = BoxShadow(
    color: Colors.black26,
    blurRadius: 8.0,
    spreadRadius: 2.0,
    offset: Offset(0, 4),
  );
}

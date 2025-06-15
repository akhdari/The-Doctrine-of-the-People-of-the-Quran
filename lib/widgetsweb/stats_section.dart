import 'package:flutter/material.dart';

/// A section displaying system statistics in a responsive grid or column layout.
class StatsSection extends StatelessWidget {
  static const List<Map<String, dynamic>> _stats = [
    {
      'icon': Icons.school,
      'label': 'عدد المدارس',
      'value': '+200'
    }, // Number of Schools
    {
      'icon': Icons.group,
      'label': 'عدد الطلاب',
      'value': '+20000'
    }, // Number of Students
    {
      'icon': Icons.person,
      'label': 'عدد المعلمين',
      'value': '+1000'
    }, // Number of Teachers
    {
      'icon': Icons.tv,
      'label': 'عدد الحلقات',
      'value': '+1200'
    }, // Number of Classes
  ];

  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: _Dimensions.verticalPadding,
        horizontal: _Dimensions.horizontalPadding,
      ),
      color: _Colors.background,
      child: Column(
        children: [
          const Text(
            'أرقام حول النظام', // System Statistics
            style: TextStyle(
              fontSize: _TextSizes.sectionTitle,
              fontWeight: FontWeight.bold,
              color: _Colors.text,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: _Dimensions.spacing),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWideScreen =
                  constraints.maxWidth > _Dimensions.breakpoint;
              return Flex(
                direction: isWideScreen ? Axis.horizontal : Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                children: _stats
                    .asMap()
                    .entries
                    .map(
                      (entry) => Padding(
                        padding: isWideScreen
                            ? const EdgeInsets.symmetric(
                                horizontal: _Dimensions.cardSpacingHorizontal)
                            : const EdgeInsets.symmetric(
                                vertical: _Dimensions.cardSpacingVertical),
                        child: StatCard(
                          stat: entry.value,
                          width: _Dimensions.cardWidth,
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// A card widget displaying a single statistic with a hover animation.
class StatCard extends StatefulWidget {
  final Map<String, dynamic> stat;
  final double width;

  const StatCard({
    required this.stat,
    this.width = _Dimensions.cardWidth,
    super.key,
  });

  @override
  StatCardState createState() => StatCardState();
}

class StatCardState extends State<StatCard> {
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
        width: widget.width,
        margin: const EdgeInsets.symmetric(vertical: _Dimensions.cardMargin),
        padding: const EdgeInsets.all(_Dimensions.cardPadding),
        decoration: BoxDecoration(
          color: _Colors.cardBackground,
          borderRadius: BorderRadius.circular(_Dimensions.borderRadius),
          boxShadow: [
            BoxShadow(
              color: _Colors.shadow,
              blurRadius: _isHovered
                  ? _Dimensions.shadowBlurHovered
                  : _Dimensions.shadowBlur,
            ),
          ],
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: _Dimensions.avatarRadius,
              backgroundColor:
                  _isHovered ? _Colors.avatarHovered : _Colors.cardBackground,
              child: Icon(
                widget.stat['icon'] as IconData,
                size: _Dimensions.iconSize,
                color: _isHovered ? _Colors.text : _Colors.icon,
              ),
            ),
            const SizedBox(height: _Dimensions.spacing),
            Text(
              widget.stat['label'] as String,
              style: const TextStyle(
                fontSize: _TextSizes.label,
                fontWeight: FontWeight.bold,
                color: _Colors.textLabel,
              ),
            ),
            const SizedBox(height: _Dimensions.spacingSmall),
            Text(
              widget.stat['value'] as String,
              style: const TextStyle(
                fontSize: _TextSizes.value,
                fontWeight: FontWeight.bold,
                color: _Colors.value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Constants for dimensions and styling
class _Dimensions {
  static const double verticalPadding = 40.0;
  static const double horizontalPadding = 20.0;
  static const double spacing = 20.0;
  static const double spacingSmall = 6.0;
  static const double cardSpacingHorizontal = 5.0;
  static const double cardSpacingVertical = 10.0;
  static const double cardWidth = 250.0;
  static const double cardMargin = 5.0;
  static const double cardPadding = 20.0;
  static const double borderRadius = 14.0;
  static const double hoverElevation = 5.0;
  static const double shadowBlur = 8.0;
  static const double shadowBlurHovered = 12.0;
  static const double avatarRadius = 40.0;
  static const double iconSize = 36.0;
  static const double breakpoint = 800.0;
}

/// Constants for colors
class _Colors {
  static const Color background = Color(0xFF0E9D6D);
  static const Color cardBackground = Colors.white;
  static const Color text = Colors.white;
  static const Color textLabel = Colors.black;
  static const Color value = Colors.teal;
  static const Color icon = Colors.orange;
  static const Color avatarHovered = Colors.orange;
  static const Color shadow = Colors.black26;
}

/// Constants for text sizes
class _TextSizes {
  static const double sectionTitle = 30.0;
  static const double label = 20.0;
  static const double value = 22.0;
}

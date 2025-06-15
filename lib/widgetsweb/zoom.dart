import 'package:flutter/material.dart';

/// A card widget that zooms slightly on hover, displaying an icon, title, price, and description.
class ZoomCard extends StatefulWidget {
  final String title;
  final String price;
  final String description;
  final IconData icon;

  const ZoomCard({
    required this.title,
    required this.price,
    required this.description,
    required this.icon,
    super.key,
  });

  @override
  ZoomCardState createState() => ZoomCardState();
}

class ZoomCardState extends State<ZoomCard> {
  // Initial scale factor for the card
  static const double _initialScale = 1.0;
  static const double _hoverScale = 1.05;

  double _scale = _initialScale;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _scale = _hoverScale), // Scale up on hover
      onExit: (_) =>
          setState(() => _scale = _initialScale), // Reset scale on exit
      child: SizedBox(
        width: _CardDimensions.width,
        height: _CardDimensions.height,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.identity()..scale(_scale),
          decoration: BoxDecoration(
            color: _CardColors.primary,
            borderRadius: BorderRadius.circular(_CardDimensions.borderRadius),
          ),
          padding: const EdgeInsets.all(_CardDimensions.padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                size: _CardDimensions.iconSize,
                color: _CardColors.text,
              ),
              const SizedBox(height: _CardDimensions.spacing),
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: _TextSizes.title,
                  fontWeight: FontWeight.bold,
                  color: _CardColors.text,
                ),
              ),
              const SizedBox(height: _CardDimensions.spacingSmall),
              Text(
                'DA ${widget.price}',
                style: const TextStyle(
                  fontSize: _TextSizes.price,
                  fontWeight: FontWeight.bold,
                  color: _CardColors.text,
                ),
              ),
              const SizedBox(height: _CardDimensions.spacingSmall),
              Text(
                widget.description,
                style: const TextStyle(
                  fontSize: _TextSizes.description,
                  color: _CardColors.text,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Constants for card dimensions and styling
class _CardDimensions {
  static const double width = 100.0;
  static const double height = 160.0;
  static const double borderRadius = 12.0;
  static const double padding = 15.0;
  static const double iconSize = 40.0;
  static const double spacing = 10.0;
  static const double spacingSmall = 5.0;
}

/// Constants for card colors
class _CardColors {
  static const Color primary = Color(0xFF0E9D6D);
  static const Color text = Colors.white;
}

/// Constants for text sizes
class _TextSizes {
  static const double title = 16.0;
  static const double price = 18.0;
  static const double description = 12.0;
}

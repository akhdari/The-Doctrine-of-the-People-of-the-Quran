import 'package:flutter/material.dart';

class CustomImage extends StatefulWidget {
  final String imagePath;
  final double? width;
  final double? height;

  const CustomImage({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
  });

  @override
  State<CustomImage> createState() => _CustomImageState();
}

class _CustomImageState extends State<CustomImage> {
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Image(
        image: AssetImage(widget.imagePath),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Icon(
            Icons.error,
            color: colorScheme.error,
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

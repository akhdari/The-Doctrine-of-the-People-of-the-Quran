import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String header;
  final String? subheader;

  const SectionHeader({
    super.key,
    required this.header,
    this.subheader,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          header,
          style: theme.textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 5),
        Divider(
          color: theme.colorScheme.primary,
          thickness: 2,
          indent: 80,
          endIndent: 80,
        ),
        if (subheader != null) ...[
          const SizedBox(height: 8),
          Text(
            subheader!,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}

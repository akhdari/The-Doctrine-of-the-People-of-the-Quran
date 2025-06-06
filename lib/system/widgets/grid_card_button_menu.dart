import 'package:flutter/material.dart';

class GridCardButtonMenu extends StatelessWidget {
  final List<Widget> children;
  final int numberColumns;

  const GridCardButtonMenu({
    super.key,
    required this.children,
    this.numberColumns = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.all(20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: numberColumns,
                mainAxisSpacing: 40.0,
                crossAxisSpacing: 40.0,
                childAspectRatio: 6,
              ),
              children: children,
            ),
          ),
        ),
      ],
    );
  }
}

class GridCardButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  const GridCardButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff169b88),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.all(40.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(title, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 16),
          Icon(icon, size: 40),
        ],
      ),
    );
  }
}

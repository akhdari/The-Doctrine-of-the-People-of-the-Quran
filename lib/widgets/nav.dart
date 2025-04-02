import 'dart:ui';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const NavBar({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List<bool> isHovered = List.generate(6, (index) => false);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isLargeScreen = constraints.maxWidth > 800;

        return isLargeScreen
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _navItems(),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(Icons.menu, color: Colors.white),
                    onPressed: () {
                      widget.scaffoldKey.currentState?.openDrawer();
                    },
                  ),
                ),
              );
      },
    );
  }

  /// Liste des éléments du menu avec animation de survol et flou en arrière-plan
  List<Widget> _navItems() {
    List<String> titles = [
      'الرئيسية',
      'الأسعار',
      'المزايا',
      'الدعم الفني',
      'التسويق بالعمولة',
      'تسجيل الدخول'
    ];

    return List.generate(titles.length, (index) {
      return MouseRegion(
        onEnter: (_) => setState(() => isHovered[index] = true),
        onExit: (_) => setState(() => isHovered[index] = false),
        child: Stack(
          alignment: Alignment.center,
          children: [
            /// Effet de flou ajusté dynamiquement à la taille du texte
            if (isHovered[index])
              LayoutBuilder(builder: (context, constraints) {
                double textWidth = _calculateTextWidth(titles[index]);

                return ClipRRect(
                  // widget that clips its child using rounded rectangle borders.
                  borderRadius: BorderRadius.circular(10),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      width: textWidth + 24, // Ajuste selon la taille du texte
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                );
              }),

            /// Texte animé avec changement de couleur et zoom
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              transform: isHovered[index]
                  ? Matrix4.diagonal3Values(1.1, 1.1, 1)
                  : Matrix4.identity(),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                titles[index],
                style: TextStyle(
                  color: isHovered[index] ? Colors.orange : Colors.white,
                  fontWeight: titles[index] == 'تسجيل الدخول'
                      ? FontWeight.w900
                      : FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  /// Fonction pour calculer dynamiquement la largeur du texte
  double _calculateTextWidth(String text) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.rtl,
    )..layout();
    return textPainter.width;
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const NavBar({super.key, required this.scaffoldKey});

  @override
  NavBarState createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  List<bool> isHovered = List.generate(6, (index) => false);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconTheme = theme.iconTheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        bool isLargeScreen = constraints.maxWidth > 800;

        return isLargeScreen
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _navItems(theme),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(Icons.menu, color: iconTheme.color),
                    onPressed: () {
                      widget.scaffoldKey.currentState?.openDrawer();
                    },
                  ),
                ),
              );
      },
    );
  }

  List<Widget> _navItems(ThemeData theme) {
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
            if (isHovered[index])
              LayoutBuilder(builder: (context, constraints) {
                double textWidth = _calculateTextWidth(titles[index]);

                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      width: textWidth + 24,
                      height: 40,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                );
              }),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              transform: isHovered[index]
                  ? Matrix4.diagonal3Values(1.1, 1.1, 1)
                  : Matrix4.identity(),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                titles[index],
                style: TextStyle(
                  color:
                      isHovered[index] ? Color(0xFFC78D20) : Color(0xFF8D9440),
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

//
  double _calculateTextWidth(String text) {
    const style = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
    );

    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.rtl,
    )..layout();

    return textPainter.width;
  }
}

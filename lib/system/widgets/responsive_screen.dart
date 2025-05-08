import 'package:flutter/material.dart';

/*check if the screen size is greater than the breakpoint, if yes 
show right side else do not show*/
class ResponsiveHide extends StatelessWidget {
  final Widget rightChild;
  final Widget leftChild;
  final double breakpoint; // Make it flexible

  const ResponsiveHide({
    super.key,
    required this.rightChild,
    required this.leftChild,
    this.breakpoint = 600, // Default value
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // Get screen width
    bool showRightSide = screenWidth > breakpoint;
    ThemeData theme = Theme.of(context);
    Color scaffoldBackgroundColor = theme.scaffoldBackgroundColor;
    Color backgroundColor = theme.colorScheme.surface;
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: ColoredBox(
              color: backgroundColor,
              child: Center(
                child: leftChild,
              ),
            ),
          ),
          if (showRightSide)
            Expanded(
              flex: 1,
              child: rightChild,
            ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

/*check if the screen size is greater than the breakpoint, if yes 
show right side else do not show*/
class ResponsiveHide extends StatelessWidget {
  final Widget rightChild;
  final Widget leftChild;
  final double breakpoint; // Make it flexible

  const ResponsiveHide({
    Key? key,
    required this.rightChild,
    required this.leftChild,
    this.breakpoint = 600, // Default value
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // Get screen width
    bool showRightSide = screenWidth > breakpoint;
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: ColoredBox(
              color: Color(0xff1D6167),
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



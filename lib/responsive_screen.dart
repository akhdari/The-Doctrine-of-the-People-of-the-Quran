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
              color: Colors.blue,
              child: Center(
                child: leftChild,
              ),
            ),
          ),
          if (showRightSide)
            Expanded(
              flex: 1,
              child: ColoredBox(
                color: Colors.white,
                child: Center(
                  child: rightChild,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/*check if the screen size is greater than the breakpoint, if yes 
show right side else display one after the other*/
class ResponsiveFollowUp extends StatelessWidget {
  final Widget rightChild;
  final Widget leftChild;
  final double breakpoint;

  const ResponsiveFollowUp({
    Key? key,
    required this.rightChild,
    required this.leftChild,
    this.breakpoint = 600,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isWideScreen = screenWidth > breakpoint;

    return Scaffold(
      body: isWideScreen
          ? Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ColoredBox(
                    color: Colors.blue,
                    child: Center(child: leftChild),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ColoredBox(
                    color: Colors.white,
                    child: Center(child: rightChild),
                  ),
                ),
              ],
            )
          : Column(
              children: [
                Expanded(
                  flex: 1,
                  child: ColoredBox(
                    color: Colors.blue,
                    child: Center(child: rightChild),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ColoredBox(
                    color: Colors.white,
                    child: Center(child: leftChild),
                  ),
                ),
              ],
            ),
    );
  }
}

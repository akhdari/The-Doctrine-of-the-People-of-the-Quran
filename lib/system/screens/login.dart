import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../system/widgets/responsive_screen.dart';
import '../../system/widgets/login.dart';
// leftchild: MyWidget(), rightchild: Text("Right Side"),

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaffoldBackgroundColor = theme.scaffoldBackgroundColor;
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: ResponsiveHide(
        leftChild: LogIn(),
        rightChild: Stack(
          children: [
            Container(
              color: theme.primaryColor,
            ),
            Positioned.fill(
              child: SvgPicture.asset(
                'illustration/welcome-sign.svg',
                fit: BoxFit.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

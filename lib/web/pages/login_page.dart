import 'package:flutter/material.dart';
import '../widgets/responsive_screen.dart';
import '../widgets/login.dart';
// leftchild: MyWidget(), rightchild: Text("Right Side"),

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveHide(
        leftChild: LogIn(),
        rightChild: Stack(
          children: [
            Container(
              color: Colors.white,
            ),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/men.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

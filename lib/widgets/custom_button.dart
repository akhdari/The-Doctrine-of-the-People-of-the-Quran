import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
//Custom Button
class CustomButton extends StatefulWidget {
  final double y;
  final GlobalKey<FormState> formKey;
  final VoidCallback toggleAnimation;
  final VoidCallback onPressFunction;
  const CustomButton({
    super.key,
    required this.y,
    required this.formKey,
    required this.toggleAnimation,
    required this.onPressFunction,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => widget.toggleAnimation(), // No need for setState here
      onExit: (event) => widget.toggleAnimation(),
      child: Transform.translate(
        offset: Offset(0, -widget.y * 5),
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ]),
          child: AnimatedButton(
            text: 'تأكيد الطلب',
            textOverflow: TextOverflow.visible,
            isReverse: true,
            onPress: widget.onPressFunction,
            transitionType: TransitionType.CENTER_LR_IN,
            borderRadius: 5,
            backgroundColor: Color(0xffBD8A36),
            selectedBackgroundColor: Colors.blueAccent,
            selectedTextColor: Colors.white,
            animationDuration: Duration(seconds: 1),
            animatedOn: AnimatedOn.onHover,
          ),
        ),
      ),
    );
  }
}

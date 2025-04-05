import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCheckbox extends StatelessWidget {
  final RxBool
      isAgree; //the reference to the Rx variable itself cannot change, but the value inside it can still be updated.
  final String text;

  CustomCheckbox({super.key, required this.isAgree, required this.text});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: RichText(
        textAlign: TextAlign.right,
        text: TextSpan(
          children: [
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Obx(() => Checkbox(
                    value: isAgree.value,
                    onChanged: (bool? value) {
                      isAgree.value = value ?? false;
                    },
                  )),
            ),
            const TextSpan(
              text: 'اوافق على ',
              style: TextStyle(color: Colors.black),
            ),
            TextSpan(
              text: text,
              style: const TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}

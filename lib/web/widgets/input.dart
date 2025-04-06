import 'package:flutter/material.dart';
class Input extends StatelessWidget {
  final bool ispassword;
  final String hintText;
  final Icon icon;
  const Input(
      {super.key,
      required this.hintText,
      this.ispassword = false,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: TextField(
        obscureText: ispassword,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          prefixIcon: Container(
            width: 50, // Set a fixed width for better styling
            height: 50, // Matches TextField height
            decoration: const BoxDecoration(
              color: Colors.blue, // Background color for icon
              borderRadius: BorderRadius.zero,
            ),
            child: icon,
          ),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(width: 1)),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(width: 1)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          hintText: hintText,
        ),
      ),
    );
  }
}
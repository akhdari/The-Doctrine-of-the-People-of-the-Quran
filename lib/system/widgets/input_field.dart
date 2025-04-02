import 'package:flutter/material.dart';

Widget inputFeild() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        "specified data:",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xff169b88),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: TextFormField(
          //text alignment
          //keyboardType
          //validator
          //maxLines
          //what is toolbarOptions
          //enabled or not = does user can interact with it
          //disabledBorder = style applied when disabled
          //enabledBorder = style applied when enabled
          //border = style applied when neither disabled nor enabled and ignored when they are set.
          //Always define at least enabledBorder and disabledBorder for better control. Use border only for simplicity.
          mouseCursor: SystemMouseCursors.text,

          controller: TextEditingController(),
          decoration: InputDecoration(
            hoverColor: Colors.transparent,
            border: OutlineInputBorder(), //may be overried by themedata
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: Color(0xff169b88),
                width: 0.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: Color(0xff169b88),
                width: 0.5,
              ),
            ),
          ),
          style: TextStyle(
            color: Color(0xffceaa63),
          ),
        ),
      ),
    ],
  );
}

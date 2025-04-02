import 'package:flutter/material.dart';
import "./custom_switch.dart";
import 'package:get/get.dart';
import "../timer.dart";
import "dart:developer";

Widget buildRow(int index, BuildContext context, String key, bool value) {
  Rx<TimeOfDay?> startTime = Rx<TimeOfDay?>(null);
  // null  is not an rx instance
  Rx<TimeOfDay?> endTime = Rx<TimeOfDay?>(null);
  /*
  Dart requires all non-nullable variables to be initialized before use.
  accessing a  non declared var will lead to run time error when accessed.
  (null) explicitly initializes the reactive variable with null.
  var without initializing it, it will be uninitialized, leading to an error when accessed.
  */

  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(key),
          CustomSwitch(),
          OutlinedButton(
            onPressed: () {
              //use set state for ui updates unless the wigets being called manage its own state
              // you overrode the old instance by doing: startTime = value.obs;
              //to update an Rx var : access its value with .value

              timer(context).then((value) => startTime.value = value);
              log(startTime.value.toString());
            },
            child: Obx(() => Text(timeToString(startTime.value))),
          ),
          OutlinedButton(
            onPressed: () {
              //use set state for ui updates unless the wigets being called manage its own state
              timer(context).then((value) => endTime.value = value);
              log(endTime.value.toString());
            },
            //This is because the Text widget is only built once when the button is created,
            //valueListenable is used to update the Text widget when the value changes
            //stream /future builder
            child: Obx(() => Text(timeToString(endTime.value))),
          ),
        ],
      ),
    ],
  );
}

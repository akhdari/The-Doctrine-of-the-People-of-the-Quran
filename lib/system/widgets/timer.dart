import 'package:flutter/material.dart';

Future<TimeOfDay?> timer(BuildContext context) async {
  TimeOfDay? result = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode:
          TimePickerEntryMode.dialOnly //where user can select time
      );

  return result;
}

//functions
String formattedDate(TimeOfDay time) {
  return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
}

String timeToString(TimeOfDay? time) {
  if (time == null) {
    return "";
  }
  return formattedDate(time);
}

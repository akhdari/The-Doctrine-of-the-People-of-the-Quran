import 'package:flutter/material.dart';

Future<String> timer(BuildContext context) async {
  /*
   using the then method does not make an asynchronous function non-asynchronous.
  */
  TimeOfDay? time;
  await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          initialEntryMode:
              TimePickerEntryMode.dialOnly //where user can select time
          )
      .then((value) {
    time = value;
  });
  return timeToString(time);
}

String formattedDate(TimeOfDay time) {
  return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
}

String timeToString(TimeOfDay? time) {
  if (time == null) {
    return "";
  } else {
    return formattedDate(time);
  }
}

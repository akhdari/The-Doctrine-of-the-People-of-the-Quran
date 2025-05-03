import 'package:flutter/material.dart';

//TODO switch to extention
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

String formattedTime(TimeOfDay time) {
  return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
}

String timeToString(TimeOfDay? time) {
  if (time == null) {
    return ""; //TODO return null
  } else {
    return formattedTime(time);
  }
}

Future<String?> dateSelector(BuildContext context) async {
  /*
   using the then method does not make an asynchronous function non-asynchronous.
  */
  DateTime? time;
  final now = DateTime.now();
  final firstDate = DateTime(now.year, 1, 1); // First day of current year
  final lastDate = DateTime(now.year, 12, 31); // Last day of current year

  await showDatePicker(
          context: context,
          firstDate: firstDate,
          lastDate: lastDate,
          initialDate: DateTime.now(),
          initialEntryMode: DatePickerEntryMode.calendarOnly)
      .then((value) {
    time = value;
  });
  return dateToString(time);
}

String formattedDate(DateTime date) {
  return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
}
//pad =add chars on the left or the right until it reaches certain length

String? dateToString(DateTime? time) {
  if (time != null) {
    return formattedDate(time);
  } else {
    return null;
  }
}

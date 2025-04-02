import 'package:flutter/material.dart';
import './build_row.dart';

class CustomMatrix extends StatefulWidget {
  const CustomMatrix({super.key});

  @override
  State<CustomMatrix> createState() => _CustomMatrixState();
}

class _CustomMatrixState extends State<CustomMatrix> {
  bool isChecked = false;
  Map<String, bool> weekDays = {
    'Mon': false,
    'Tue': false,
    'Wed': false,
    'Thu': false,
    'Fri': false,
    'Sat': false,
    'Sun': false
  };
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: weekDays.length,
        itemBuilder: (context, index) {
          return buildRow(index, context, weekDays.keys.toList()[index],
              weekDays.values.toList()[index]);
        },
      ),
    );
  }
}

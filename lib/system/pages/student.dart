import 'package:flutter/material.dart';

import '../widgets/table/file3.dart';

const url = 'http://192.168.100.20/phpscript/student.php';
//should match the data list map keys

List<String> keys = [
  'first_name_ar',
  'last_name_ar',
  'sex',
  'date_of_birth',
  'place_of_birth',
  'nationality',
  'lecture_name_ar',
  'username'
];

class Student extends StatelessWidget {
  const Student({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomDataTable(
      url: url,
      rowsPerPage: 2,
      colums: keys,
      rows: keys,
    ));
  }
}

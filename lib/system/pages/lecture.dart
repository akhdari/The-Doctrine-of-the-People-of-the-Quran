import 'package:flutter/material.dart';
import '../widgets/table/file3.dart';

const url = 'http://192.168.100.20/phpscript/lecture.php';
List<String> keys = [
  "lecture_name_ar",
  "circle_type",
  "teacher_ids",
  "student_count"
];

class Lecture extends StatelessWidget {
  const Lecture({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomDataTable(
        url: url,
        rowsPerPage: 2,
        rows: keys,
        colums: keys,
      ),
    );
  }
}

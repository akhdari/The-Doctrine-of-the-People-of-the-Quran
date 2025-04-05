import 'package:flutter/material.dart';
import '../widgets/table/file3.dart';

const url = 'http://192.168.100.20/phpscript/guardian.php';
List<String> keys = [
  "last_name",
  "first_name",
  "date_of_birth",
  "relationship",
  "phone_number",
  "email",
  "guardian_account",
  "student_account",
  "children"
];

class Guardian extends StatelessWidget {
  const Guardian({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomDataTable(url: url, rowsPerPage: 2, colums: keys, rows: keys),
    );
  }
}

import 'package:flutter/material.dart';
import './file2.dart';

class CustomDataTable extends StatelessWidget {
  final int rowsPerPage;
  List<String> colums = [""]; //List.empty(growable: true)
  List<String> rows = [""];
  CustomDataTable(
      {required this.rowsPerPage,
      required this.colums,
      required this.rows,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TablePage(
      rowsPerPage: rowsPerPage,
      colums: colums,
      rows: rows,
    );
  }
}

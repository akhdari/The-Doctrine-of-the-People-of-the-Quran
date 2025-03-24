import 'package:flutter/material.dart';
import './file1.dart';
import './file2.dart';

class TablePage extends StatelessWidget {
  final int rowsPerPage;
  List colums = List.empty(growable: true);
  List rows = List.empty(growable: true);

  TablePage(
      {required this.rowsPerPage,
      required this.colums,
      required this.rows,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

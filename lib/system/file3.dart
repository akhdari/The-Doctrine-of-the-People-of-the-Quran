import 'package:flutter/material.dart';
import './file2.dart';

class CustomDataTable extends StatefulWidget {
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
  State<CustomDataTable> createState() => _CustomDataTableState();
}

class _CustomDataTableState extends State<CustomDataTable> {
  @override
  Widget build(BuildContext context) {
    return TablePage(
      rowsPerPage: widget.rowsPerPage,
      colums: widget.colums,
      rows: widget.rows,
    );
  }
}

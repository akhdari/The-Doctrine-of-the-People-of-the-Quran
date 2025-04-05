import 'package:flutter/material.dart';
import './file2.dart';

class CustomDataTable extends StatefulWidget {
  final int rowsPerPage;
  final String url;
  final List<String> colums;
  final List<String> rows;
  const CustomDataTable({
    required this.url,
    required this.rowsPerPage,
    required this.colums,
    required this.rows,
    super.key,
  });

  @override
  State<CustomDataTable> createState() => _CustomDataTableState();
}

class _CustomDataTableState extends State<CustomDataTable> {
  @override
  Widget build(BuildContext context) {
    return TablePage(
      url: widget.url,
      rowsPerPage: widget.rowsPerPage,
      colums: widget.colums,
      rows: widget.rows,
    );
  }
}

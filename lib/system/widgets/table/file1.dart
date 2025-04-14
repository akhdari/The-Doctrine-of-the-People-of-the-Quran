import 'dart:core';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/connect/connect.dart';

class MyDataTableSource extends AsyncDataTableSource {
  final String url;
  String search = "";
  int sortIndex = 0;
  bool sortAscending = true;
  final List<String> sortKeys;

  MyDataTableSource({
    required this.url,
    required this.search,
    required this.sortIndex,
    required this.sortAscending,
    required this.sortKeys,
  });
//TODO data availibility
  @override
  Future<AsyncRowsResponse> getRows(int startIndex, int count) async {
    // network request
    Connect connect = Connect();
    List<Map<String, dynamic>> data;
    ApiResult<List<Map<String, dynamic>>> apiResultData =
        await connect.get(url);
    data = apiResultData.data!;

    List<Map<String, dynamic>> studentList = data;
    dev.log("studentList: $studentList");
    void sortList(
      List<Map<String, dynamic>> list,
      int sortIndex,
      String search,
      List<String> sortKeys,
    ) {
      if (search.isNotEmpty) {
        list.removeWhere(
          (e) => !e[sortKeys[0]].toString().contains(search.toLowerCase()),
        );
      } else if (sortIndex >= 0 && sortIndex < sortKeys.length) {
        list.sort(
          (a, b) => a[sortKeys[sortIndex]].compareTo(b[sortKeys[sortIndex]]),
        );
      }
    }

    sortList(studentList, sortIndex, search, sortKeys);

    //order
    if (!sortAscending) {
      studentList = studentList.reversed.toList();
    }

    List<Map<String, dynamic>> studentListPage =
        studentList.getRange(startIndex, startIndex + count).toList();

    return AsyncRowsResponse(
      data.length,
      studentListPage.map((item) {
        List<DataCell> dataCells = sortKeys.map((column) {
          return DataCell(Text(item[column].toString()));
        }).toList();
        return DataRow(cells: dataCells);
      }).toList(),
    );
  }
}

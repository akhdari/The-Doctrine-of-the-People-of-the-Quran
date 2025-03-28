import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import '../connect/connect.dart';

const url = 'http://192.168.100.20/phpscript/connect.php';

Future<List<Map<String, dynamic>>> fetchData() async {
  try {
    Connect connect = Connect();
    Map<String, dynamic>? data = await connect.get(url);
    log("Received Data: $data"); // Debug print
    if (data != null) {
      return [data];
    } else {
      return []; //empty list , not nullable
    }
  } catch (e) {
    throw Exception(e);
  }
}

class MyDataTableSource extends AsyncDataTableSource {
//data source
//attributes
  String search = "";
  int sortIndex = 0;
  bool sortAscending = true;
  List<String> rows = [""];

//constructor
  MyDataTableSource(
      {required this.search,
      required this.sortIndex,
      required this.sortAscending,
      required this.rows});

  @override
  Future<AsyncRowsResponse> getRows(int startIndex, int count) async {
    // network request
    List<Map<String, dynamic>> data = await fetchData();
    List<Map<String, dynamic>> studentList = data;
    log("studentList: $studentList");
    //filter
    if (search.isNotEmpty) {
      //list.removeWhere((element) => condition);
      //by default search by last names
      //e=list element
      //e[map key]=map value
      studentList.removeWhere(
          (e) => !e["last_name"].toString().contains(search.toLowerCase()));
    } else {
      switch (sortIndex) {
        case 0:
          studentList.sort((a, b) => a["id"]
              .compareTo(b["id"])); //sort each 2 by 2 elements in the list}
          break;
        case 1:
          studentList.sort((a, b) =>
              a["first_name_arabic"].compareTo(b["first_name_arabic"]));
          break;
        case 2:
          studentList.sort(
              (a, b) => a["first_name_latin"].compareTo(b["first_name_latin"]));
          break;
      }
    }
    //order
    if (!sortAscending) {
      studentList = studentList.reversed
          .toList(); // reverse does not modify the original list instead it returns a an iterable
      //iteratable is a collection that you can iterate through
    }
    // pagenation
    /*
    breaking large data into smaller chunks (pages) for better performance 
    */
    //TODO how is start index updated
    List<Map<String, dynamic>> studentListPage =
        studentList.getRange(startIndex, startIndex + count).toList();
    // getRange(startIndex, endIndex) or skip(startIndex).take(count) start from the index and take the next count elements

    return AsyncRowsResponse(
      data.length,
      studentListPage.map((item) {
        return DataRow(
          cells: rows.map((e) => DataCell(Text(item[e].toString()))).toList(),
        );
      }).toList(), // Convert Iterable to List here!
    );
  }
}

/*
DataTable 
DataRow 
DataCell 
how to use:
DataRow(cells: [
  DataCell(),
])
*/

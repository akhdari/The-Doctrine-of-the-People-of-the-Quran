import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import '../connect/connect.dart';

const url = 'http://192.168.100.20/phpscript/connect.php';

Future<List<Map<String, dynamic>>> fetchData() async {
  try {
    final connect = Connect();
    final data = await connect.get(url);
    log("Received Data: $data");
    return data;
  } catch (e) {
    log("Error fetching data: $e");
    throw Exception('Failed to fetch data: $e');
  }
}

class MyDataTableSource extends AsyncDataTableSource {
//data source

//attributes
  String search = "";
  int sortIndex = 0;
  bool sortAscending = true;
  // List<String> rows = [];

//constructor
  MyDataTableSource({
    required this.search,
    required this.sortIndex,
    required this.sortAscending,
    //required this.rows
  });

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
          (e) => !e["first_name_ar"].toString().contains(search.toLowerCase()));
    } else {
      switch (sortIndex) {
        case 0:
          studentList.sort((a, b) => a["first_name_ar"].compareTo(
              b["first_name_ar"])); //sort each 2 by 2 elements in the list}
          break;
        case 1:
          studentList
              .sort((a, b) => a["last_name_ar"].compareTo(b["last_name_ar"]));
          break;
        case 2:
          studentList.sort((a, b) => a["sex"].compareTo(b["sex"]));
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
            cells: //rows.map((e) => DataCell(Text(item[e].toString()))).toList(),
                [
              DataCell(Text(item["first_name_ar"].toString())),
              DataCell(Text(item["last_name_ar"].toString())),
              DataCell(Text(item["sex"].toString())),
              DataCell(Text(item["date_of_birth"].toString())),
              DataCell(Text(item["place_of_birth"].toString())),
              DataCell(Text(item["nationality"].toString())),
              DataCell(Text(item["lecture_name_ar"].toString())),
              DataCell(Text(item["username"].toString())),
            ]);
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

import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class MyDataTableSource extends AsyncDataTableSource {
  //data source
  List<Map<String, dynamic>> data = [
    {
      "id": 5462,
      "last_name": "Ali",
      "first_name_arabic": "فاطمة",
      "first_name_latin": "Ali"
    },
    {
      "id": 7103,
      "last_name": "Hassan",
      "first_name_arabic": "علي",
      "first_name_latin": "Fatima"
    },
    {
      "id": 9354,
      "last_name": "Saeed",
      "first_name_arabic": "زينب",
      "first_name_latin": "Hassan"
    },
    {
      "id": 1734,
      "last_name": "Ahmad",
      "first_name_arabic": "حسن",
      "first_name_latin": "Mohammad"
    },
    {
      "id": 4097,
      "last_name": "Nour",
      "first_name_arabic": "محمد",
      "first_name_latin": "Zainab"
    }
  ];
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
    List<Map<String, dynamic>> studentList = data;
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

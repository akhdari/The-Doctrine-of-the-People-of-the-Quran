import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './file1.dart';

class TablePage extends StatelessWidget {
  RxString searchQuery = ''.obs;
  RxBool asc = true.obs;
  RxInt sortIndex = 0.obs;
  List<String> colums = [""];
  List<String> rows = [""];
  int rowsPerPage;
//TODO if rowsPerPage is not provided the default value
  TablePage(
      {required this.colums,
      required this.rows,
      required this.rowsPerPage,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            onChanged: (value) => searchQuery.value = value,
          ),
          Expanded(
            child: Obx(
              () {
                return AsyncPaginatedDataTable2(
                  empty: Text("Empty"),
                  rowsPerPage: rowsPerPage,
                  columns: colums
                      .map((e) => DataColumn(
                          label: Text(e),
                          onSort: (columnIndex, ascending) {
                            sortIndex.value = columnIndex;
                            asc.value = asc.isFalse;
                          }))
                      .toList(),
                  /* DataColumn(
                      label: Text('ID'),
                      onSort: (columnIndex, ascending) {
                        sortIndex.value = columnIndex;
                        asc.value = asc.isFalse;
                      },
                    ),*/

                  /*
                  in DataTable the order and the count of datacells in datarows must match datacolums 
                  unlike naming which they dont have to match
                  the label of data column is used for display 
                  */
                  source: MyDataTableSource(
                    // rows: rows,
                    search: searchQuery.value,
                    sortIndex: sortIndex.value,
                    sortAscending: asc.value,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

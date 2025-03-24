import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './file1.dart';

class TablePage extends StatelessWidget {
  RxString searchQuery = ''.obs;
  RxBool asc = true.obs;
  RxInt sortIndex = 0.obs;
  TablePage({super.key});

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
                  rowsPerPage: 2,
                  columns: [
                    //TODO to be updated
                    DataColumn(
                      label: Text('ID'),
                      onSort: (columnIndex, ascending) {
                        sortIndex.value = columnIndex;
                        asc.value = asc.isFalse;
                      },
                    ),
                    DataColumn(
                        label: Text('First Name Arabic'),
                        onSort: (columnIndex, ascending) {
                          sortIndex.value = columnIndex;
                          asc.value = asc.isFalse;
                        }),
                    DataColumn(
                      label: Text('First Name Latin'),
                      onSort: (columnIndex, ascending) {
                        sortIndex.value = columnIndex;
                        asc.value = asc.isFalse;
                      },
                    ),
                    DataColumn(
                        label: Text('Last Name Arabic'),
                        onSort: (columnIndex, ascending) {
                          sortIndex.value = columnIndex;
                          asc.value = asc.isFalse;
                        }),
                    DataColumn(
                        label: Text('Last Name Latin'),
                        onSort: (columnIndex, ascending) {
                          sortIndex.value = columnIndex;
                          asc.value = asc.isFalse;
                        }),
                  ],
                  /*
                  in DataTable the order and the count of datacells in datarows must match datacolums 
                  unlike naming which they dont have to match
                  the label of data column is used for display 
                  */
                  source: MyDataTableSource(
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

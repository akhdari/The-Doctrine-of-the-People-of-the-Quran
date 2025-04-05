import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'file1.dart';

class TablePage extends StatelessWidget {
  final String url;
  final RxString searchQuery = ''.obs;
  final RxBool asc = true.obs;
  final RxInt sortIndex = 0.obs;
  final List<String> colums;
  final List<String> rows;
  final int rowsPerPage;
  TablePage({
    required this.url,
    required this.colums,
    required this.rows,
    required this.rowsPerPage,
    super.key,
  });
  final ScrollController scrollController = ScrollController();
  final PaginatorController paginatorController = PaginatorController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(onChanged: (value) => searchQuery.value = value),
          Expanded(
            child: Obx(() {
              return AsyncPaginatedDataTable2(
                scrollController: scrollController,
                controller: paginatorController,
                empty: Text("Empty"),
                headingRowDecoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xff169b88),
                  ),
                  borderRadius: BorderRadius.zero,
                ),
                dividerThickness: 1,
                /*
                if less display the available
                if more move to the next page and display
                if not specified display all in one page
                */
                rowsPerPage: rowsPerPage,
                columns: colums
                    .map(
                      (e) => DataColumn(
                        label: Text(e),
                        onSort: (columnIndex, ascending) {
                          sortIndex.value = columnIndex;
                          asc.value = asc.isFalse;
                        },
                      ),
                    )
                    .toList(),
                source: MyDataTableSource(
                  url: url,
                  sortKeys: colums,
                  search: searchQuery.value,
                  sortIndex: sortIndex.value,
                  sortAscending: asc.value,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../models/grid/generic_data_grid.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../models/get/acheivement_class.dart';
import 'package:get/get.dart';
import '/system/widgets/dialogs/acheivement.dart';

class AcheivementGrid extends StatelessWidget {
  final Future<List<Acheivement>> Function() dataFetcher;

  const AcheivementGrid({
    super.key,
    required this.dataFetcher,
  });

  @override
  Widget build(BuildContext context) {
    return GenericDataGrid<Acheivement>(
      dataFetcher: dataFetcher,
      onDelete: null,
      selectionMode: SelectionMode.none,
      screenTitle: 'Acheivements List',
      detailsTitle: 'Acheivement Details',
      rowsPerPage: 10,
      showCheckBoxColumn: false,
      idExtractor: (row) => row.getCells()[0].value.toString(),
      rowBuilder: (acheivement) => DataGridRow(cells: [
        DataGridCell<String>(
            columnName: 'student_id', value: acheivement.studentID),
        DataGridCell<String>(
            columnName: 'full_name', value: acheivement.studentName),
        DataGridCell<String>(columnName: 'acheivement', value: null),

        /*  DataGridCell<GestureDetector>(
            columnName: 'acheivement',
            value: GestureDetector(
              onTap: () {
                Get.dialog(AcheivemtDialog());
              },
            )),*/
        DataGridCell<String>(columnName: 'attendance', value: null),
      ]),
      cellBuilder: (cell) {
        if (cell.columnName == 'acheivement') {
          return GestureDetector(
            onTap: () {
              Get.dialog(AcheivemtDialog());
            },
          );
        } else {
          return null;
        }
      },
      columns: [
        GridColumn(columnName: 'student_id', label: _buildHeader('Student ID')),
        GridColumn(
            columnName: 'student_name', label: _buildHeader('Student Name')),
        GridColumn(
            columnName: 'acheivement', label: _buildHeader('Acheivement')),
        GridColumn(columnName: 'attendance', label: _buildHeader('Attendance')),
      ],
    );
  }

  Widget _buildHeader(String title) {
    return Container(
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Text(title, overflow: TextOverflow.ellipsis),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/appreciation.dart';
import '../../../models/grid/generic_data_grid.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class NotesGrid extends StatelessWidget {
  final List<Appreciation> data;
  final Future<void> Function(int id) onDelete;
  final Future<void> Function() onRefresh;
  final void Function(Appreciation? obj)? getObj;

  const NotesGrid({
    super.key,
    required this.data,
    required this.onDelete,
    required this.onRefresh,
    required this.getObj,
  });

  @override
  Widget build(BuildContext context) {
    return GenericDataGrid<Appreciation>(
      data: data,
      // selectionMode: SelectionMode.singleDeselect,
      getObj: (row) {
        if (getObj != null) {
          getObj!(row);
        }
      },
      onDelete: onDelete,
      onRefresh: onRefresh,
      screenTitle: 'Exam List',
      detailsTitle: 'Exam Details',
      rowsPerPage: 10,
      showCheckBoxColumn: true,
      idExtractor: (row) => int.parse(row.getCells()[0].value),
      rowBuilder: (exam) => DataGridRow(cells: [
        DataGridCell<String>(
            columnName: 'id', value: exam.appreciationId.toString()),
        DataGridCell<int>(columnName: 'min_point', value: exam.pointMin),
        DataGridCell<int>(columnName: 'max_point', value: exam.pointMax),
        DataGridCell<String>(columnName: 'note', value: exam.note),
        DataGridCell<String>(columnName: 'button', value: null),
      ]),
      columns: [
        GridColumn(columnName: 'id', label: _buildHeader('ID')),
        GridColumn(columnName: 'max_point', label: _buildHeader('Max Point')),
        GridColumn(columnName: 'min_point', label: _buildHeader('Min Point')),
        GridColumn(columnName: 'note', label: _buildHeader('Note')),
        GridColumn(
          columnName: 'button',
          label: _buildHeader('Action'),
          allowSorting: false,
          allowFiltering: false,
        ),
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

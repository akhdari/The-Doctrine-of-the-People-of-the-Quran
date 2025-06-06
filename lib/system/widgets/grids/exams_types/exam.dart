import 'package:flutter/material.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/exam.dart';
import '../../../models/grid/generic_data_grid.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ExamGrid extends StatelessWidget {
  final List<Exam> data;
  final Future<void> Function(int id) onDelete;
  final Future<void> Function() onRefresh;
  final void Function(Exam? obj)? getObj;

  const ExamGrid({
    super.key,
    required this.data,
    required this.onDelete,
    required this.onRefresh,
    required this.getObj,
  });

  @override
  Widget build(BuildContext context) {
    return GenericDataGrid<Exam>(
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
        DataGridCell<String>(columnName: 'id', value: exam.examId.toString()),
        DataGridCell<String>(columnName: 'exam_name', value: exam.examNameAr),
        DataGridCell<int>(columnName: 'max_point', value: exam.examMaxPoint),
        DataGridCell<int>(
            columnName: 'min_point', value: exam.examSucessMinPoint),
        DataGridCell<String>(columnName: 'type', value: exam.examType),
        DataGridCell<int>(
            columnName: 'exam_memo_point', value: exam.examMemoPoint),
        DataGridCell<int>(
            columnName: 'exam_tjwid_app_point', value: exam.examTjwidAppPoint),
        DataGridCell<int>(
            columnName: 'exam_tjwid_tho_point', value: exam.examTjwidThoPoint),
        DataGridCell<int>(
            columnName: 'exam_performance_point',
            value: exam.examPerformancePoint),
        DataGridCell<String>(columnName: 'button', value: null),
      ]),
      columns: [
        GridColumn(columnName: 'id', label: _buildHeader('ID')),
        GridColumn(columnName: 'exam_name', label: _buildHeader('Exam Name')),
        GridColumn(columnName: 'max_point', label: _buildHeader('Max Point')),
        GridColumn(columnName: 'min_point', label: _buildHeader('Min Point')),
        GridColumn(columnName: 'type', label: _buildHeader('Type')),
        GridColumn(
            columnName: 'exam_memo_point',
            label: _buildHeader('Memorization Point')),
        GridColumn(
            columnName: 'exam_tjwid_app_point',
            label: _buildHeader('Tjwid Applicative Point')),
        GridColumn(
            columnName: 'exam_tjwid_tho_point',
            label: _buildHeader('Tjwid Theoric Point')),
        GridColumn(
            columnName: 'exam_performance_point',
            label: _buildHeader('Performance Point')),
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

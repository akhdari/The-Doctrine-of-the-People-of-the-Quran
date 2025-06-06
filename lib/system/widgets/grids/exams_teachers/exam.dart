import 'package:flutter/material.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/models/post/exam_teachers.dart';
import '../../../models/grid/generic_data_grid.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TeacherGrid extends StatelessWidget {
  final List<ExamTeacherInfoDialog> data;
  final Future<void> Function(int id) onDelete;
  final Future<void> Function() onRefresh;
  final void Function(ExamTeacherInfoDialog? obj)? getObj;

  const TeacherGrid({
    super.key,
    required this.data,
    required this.onDelete,
    required this.onRefresh,
    required this.getObj,
  });

  @override
  Widget build(BuildContext context) {
    return GenericDataGrid<ExamTeacherInfoDialog>(
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
            columnName: 'id', value: exam.techer.teacherAccountId.toString()),
        DataGridCell<String>(
            columnName: 'exam_name',
            value: exam.exam.map((e) => e.examNameAr).join(', ')),
        DataGridCell<String>(
            columnName: 'teacher_name',
            value: '${exam.techer.firstName} ${exam.techer.lastName}'),
        DataGridCell<String>(columnName: 'button', value: null),
      ]),
      columns: [
        GridColumn(columnName: 'id', label: _buildHeader('ID')),
        GridColumn(columnName: 'exam_name', label: _buildHeader('Exam Name')),
        GridColumn(
            columnName: 'teacher_name', label: _buildHeader('Teacher Name')),
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

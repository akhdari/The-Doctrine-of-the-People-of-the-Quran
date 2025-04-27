import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../models/grid/generic_data_grid.dart';
import '../../../models/get/lecture_class.dart';

class LectureGrid extends StatelessWidget {
  final List<Lecture> data;
  final Future<void> Function(int id) onDelete;
  final Future<void> Function() onRefresh;

  const LectureGrid({
    super.key,
    required this.data,
    required this.onDelete,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return GenericDataGrid<Lecture>(
      data: data,
      onDelete: onDelete,
      onRefresh: onRefresh,
      //selectionMode: SelectionMode.singleDeselect,
      screenTitle: 'Lectures List',
      detailsTitle: 'Lecture Details',
      rowsPerPage: 10,
      showCheckBoxColumn: true,
      idExtractor: (row) => row.getCells()[0].value.toString(),
      rowBuilder: (lecture) => DataGridRow(cells: [
        DataGridCell<String>(columnName: 'id', value: lecture.id),
        DataGridCell<String>(
            columnName: 'lecture_name_ar', value: lecture.lectureNameAr),
        DataGridCell<String>(
            columnName: 'circle_type', value: lecture.circleType),
        DataGridCell<String>(
            columnName: 'teacher_ids', value: lecture.teacherIds.toString()),
        DataGridCell<int>(
            columnName: 'student_count', value: lecture.studentCount),
        DataGridCell<String>(columnName: 'button', value: null),
      ]),
      columns: [
        GridColumn(columnName: 'id', label: _buildHeader('ID')),
        GridColumn(
            columnName: 'lecture_name_ar', label: _buildHeader('Name (AR)')),
        GridColumn(columnName: 'circle_type', label: _buildHeader('Type')),
        GridColumn(columnName: 'teacher_ids', label: _buildHeader('Teachers')),
        GridColumn(
            columnName: 'student_count', label: _buildHeader('Students')),
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

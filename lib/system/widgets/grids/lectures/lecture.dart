import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/models/post/lecture.dart';
import '../../../models/grid/generic_data_grid.dart';
import 'dart:developer' as dev;

class LectureGrid extends StatelessWidget {
  final List<LectureForm> data;
  final Future<void> Function(int id) onDelete;
  final Future<void> Function() onRefresh;
  final void Function(DataGridRow?)? onTap;
  final void Function(LectureForm?)? getObj;

  const LectureGrid({
    super.key,
    required this.data,
    required this.onDelete,
    required this.onRefresh,
    this.onTap,
    this.getObj,
  });

  @override
  Widget build(BuildContext context) {
    return GenericDataGrid<LectureForm>(
      data: data,
      onDelete: onDelete,
      onRefresh: onRefresh,
      getDataGridRow: (row) {
        if (onTap != null) onTap!(row);
      },
      getObj: (obj) {
        if (getObj != null) {
          dev.log('Selected lecture: ${obj?.lecture.lectureNameAr}');
          getObj!(obj);
        }
      },
      selectionMode: SelectionMode.singleDeselect,
      screenTitle: 'Lectures List',
      detailsTitle: 'Lecture Details',
      rowsPerPage: 10,
      showCheckBoxColumn: true,
      idExtractor: (row) => int.parse(row.getCells()[0].value),
      rowBuilder: (lecture) => DataGridRow(cells: [
        DataGridCell<String>(
            columnName: 'id', value: lecture.lecture.lectureId.toString()),
        DataGridCell<String>(
            columnName: 'lecture_name_ar',
            value: lecture.lecture.lectureNameAr),
        DataGridCell<String>(
            columnName: 'circle_type', value: lecture.lecture.circleType),
        DataGridCell<String>(
            columnName: 'teacher_ids',
            value: lecture.teachers
                .map((t) => '${t.firstName} ${t.lastName}')
                .join(', ')),
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

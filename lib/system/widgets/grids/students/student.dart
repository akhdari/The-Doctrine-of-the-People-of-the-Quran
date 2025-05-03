import 'package:flutter/material.dart';
import '../../../models/grid/generic_data_grid.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../models/get/student_class.dart'; // Your student model

class StudentGrid extends StatelessWidget {
  final List<Student> data;
  final Future<void> Function(int id) onDelete;
  final Future<void> Function() onRefresh;

  const StudentGrid({
    super.key,
    required this.data,
    required this.onDelete,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return GenericDataGrid<Student>(
      data: data,
      // selectionMode: SelectionMode.singleDeselect,
      onDelete: onDelete,
      onRefresh: onRefresh,
      screenTitle: 'Students List',
      detailsTitle: 'Student Details',
      rowsPerPage: 10,
      showCheckBoxColumn: true,
      idExtractor: (row) => int.parse(row.getCells()[0].value),
      rowBuilder: (student) => DataGridRow(cells: [
        DataGridCell<String>(columnName: 'id', value: student.id),
        DataGridCell<String>(
            columnName: 'first_name_ar', value: student.firstNameAr),
        DataGridCell<String>(
            columnName: 'last_name_ar', value: student.lastNameAr),
        DataGridCell<String>(columnName: 'sex', value: student.sex),
        DataGridCell<String>(
            columnName: 'date_of_birth', value: student.dateOfBirth),
        DataGridCell<String>(
            columnName: 'place_of_birth', value: student.placeOfBirth),
        DataGridCell<String>(
            columnName: 'nationality', value: student.nationality),
        DataGridCell<String>(
            columnName: 'lecture_name_ar', value: student.lectureNameAr),
        DataGridCell<String>(columnName: 'username', value: student.username),
        DataGridCell<String>(columnName: 'button', value: null),
      ]),
      columns: [
        GridColumn(columnName: 'id', label: _buildHeader('ID')),
        GridColumn(
            columnName: 'first_name_ar',
            label: _buildHeader('First Name (AR)')),
        GridColumn(
            columnName: 'last_name_ar', label: _buildHeader('Last Name (AR)')),
        GridColumn(columnName: 'sex', label: _buildHeader('Sex')),
        GridColumn(
            columnName: 'date_of_birth', label: _buildHeader('Date of Birth')),
        GridColumn(
            columnName: 'place_of_birth',
            label: _buildHeader('Place of Birth')),
        GridColumn(
            columnName: 'nationality', label: _buildHeader('Nationality')),
        GridColumn(
            columnName: 'lecture_name_ar', label: _buildHeader('Lecture')),
        GridColumn(columnName: 'username', label: _buildHeader('Username')),
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

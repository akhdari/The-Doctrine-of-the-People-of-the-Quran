import 'package:flutter/material.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/models/post/student.dart';
import '../../../models/grid/generic_data_grid.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class StudentGrid extends StatelessWidget {
  final List<StudentInfoDialog> data;
  final Future<void> Function(int id) onDelete;
  final Future<void> Function() onRefresh;
  final void Function(StudentInfoDialog?)? getObj;

  const StudentGrid({
    super.key,
    required this.data,
    required this.onDelete,
    required this.onRefresh,
    this.getObj,
  });

  @override
  Widget build(BuildContext context) {
    return GenericDataGrid<StudentInfoDialog>(
      data: data,
      // selectionMode: SelectionMode.singleDeselect,
      getObj: (row) {
        if (getObj != null) {
          getObj!(row);
        }
      },
      onDelete: onDelete,
      onRefresh: onRefresh,
      screenTitle: 'Students List',
      detailsTitle: 'Student Details',
      rowsPerPage: 10,
      showCheckBoxColumn: true,
      idExtractor: (row) => int.parse(row.getCells()[0].value),
      rowBuilder: (student) => DataGridRow(cells: [
        DataGridCell<String>(
            columnName: 'id', value: student.personalInfo.studentId.toString()),
        DataGridCell<String>(
            columnName: 'first_name_ar',
            value: student.personalInfo.firstNameAr),
        DataGridCell<String>(
            columnName: 'last_name_ar', value: student.personalInfo.lastNameAr),
        DataGridCell<String>(
            columnName: 'sex', value: student.personalInfo.sex),
        DataGridCell<String>(
            columnName: 'date_of_birth',
            value: student.personalInfo.dateOfBirth),
        DataGridCell<String>(
            columnName: 'place_of_birth',
            value: student.personalInfo.placeOfBirth),
        DataGridCell<String>(
            columnName: 'nationality', value: student.personalInfo.nationality),
        DataGridCell<String>(
            columnName: 'lecture_name_ar',
            value: student.lectures.isNotEmpty
                ? student.lectures.map((e) => e.lectureNameAr).join(', ')
                : 'No Lecture Assigned'),
        DataGridCell<String>(
            columnName: 'username', value: student.accountInfo.username),
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

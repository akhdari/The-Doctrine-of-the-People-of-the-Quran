import 'package:flutter/material.dart';
import '../../../models/grid/generic_data_grid.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../models/get/guardian_class.dart';

class GuardianGrid extends StatelessWidget {
  final Future<List<Guardian>> Function() dataFetcher;
  final Future<void> Function(int id) onDelete;

  const GuardianGrid({
    super.key,
    required this.dataFetcher,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GenericDataGrid<Guardian>(
      dataFetcher: dataFetcher,
      onDelete: onDelete,
      screenTitle: 'Guardians List',
      detailsTitle: 'Guardian Details',
      rowsPerPage: 10,
      idExtractor: (row) => row.getCells()[0].value.toString(),
      rowBuilder: (guardian) => DataGridRow(cells: [
        DataGridCell<String>(columnName: 'id', value: guardian.id),
        DataGridCell<String>(
            columnName: 'first_name', value: guardian.firstName),
        DataGridCell<String>(columnName: 'last_name', value: guardian.lastName),
        DataGridCell<String>(
            columnName: 'date_of_birth', value: guardian.dateOfBirth),
        DataGridCell<String>(
            columnName: 'relationship', value: guardian.relationship),
        DataGridCell<String>(
            columnName: 'phone_number', value: guardian.phoneNumber),
        DataGridCell<String>(columnName: 'email', value: guardian.email),
        DataGridCell<String>(
            columnName: 'guardian_account', value: guardian.guardianAccount),
        DataGridCell<String>(
            columnName: 'children', value: guardian.children.toString()),
        DataGridCell<String>(columnName: 'button', value: null),
      ]),
      columns: [
        GridColumn(columnName: 'id', label: _buildHeader('ID')),
        GridColumn(columnName: 'first_name', label: _buildHeader('First Name')),
        GridColumn(columnName: 'last_name', label: _buildHeader('Last Name')),
        GridColumn(
            columnName: 'date_of_birth', label: _buildHeader('Date of Birth')),
        GridColumn(
            columnName: 'relationship', label: _buildHeader('Relationship')),
        GridColumn(columnName: 'phone_number', label: _buildHeader('Phone')),
        GridColumn(columnName: 'email', label: _buildHeader('Email')),
        GridColumn(
            columnName: 'guardian_account', label: _buildHeader('Account')),
        GridColumn(columnName: 'children', label: _buildHeader('Children')),
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

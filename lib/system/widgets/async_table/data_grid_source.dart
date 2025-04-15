import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import './data_class.dart';

class GuardianDataSource extends DataGridSource {
  GuardianDataSource(
      {required List<Guardian> guardians, required int rowsPerPage})
      : _rowsPerPage = rowsPerPage {
    _guardianData = guardians;
    _paginatedGuardians = guardians.take(_rowsPerPage).toList();
    buildDataGridRows();
  }

  late List<Guardian> _guardianData;
  late List<Guardian> _paginatedGuardians;
  late List<DataGridRow> _rows;
  final int _rowsPerPage;

  @override
  List<DataGridRow> get rows => _rows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map((dataGridCell) {
      return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(dataGridCell.value.toString(),
            overflow: TextOverflow.ellipsis),
      );
    }).toList());
  }

  void buildDataGridRows() {
    _rows = _paginatedGuardians.map<DataGridRow>((Guardian guardian) {
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'id', value: guardian.id),
        DataGridCell<String>(columnName: 'last_name', value: guardian.lastName),
        DataGridCell<String>(
            columnName: 'first_name', value: guardian.firstName),
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
      ]);
    }).toList(growable: false);
  }

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startIndex = newPageIndex * _rowsPerPage;
    int endIndex = startIndex + _rowsPerPage;

    if (startIndex < _guardianData.length) {
      endIndex =
          endIndex > _guardianData.length ? _guardianData.length : endIndex;
      _paginatedGuardians = _guardianData.sublist(startIndex, endIndex);
      buildDataGridRows();
      notifyListeners();
    } else {
      _paginatedGuardians = [];
      buildDataGridRows();
      notifyListeners();
    }

    return true;
  }
}

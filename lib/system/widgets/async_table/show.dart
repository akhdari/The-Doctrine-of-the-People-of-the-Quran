import 'package:flutter/material.dart';
import 'dart:developer' as dev;
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import './data_class.dart';
import '/system/connect/connect.dart';
import '/system/const/guardian_delete_class.dart';
import 'package:get/get.dart';

const String fetchUrl = 'http://192.168.100.20/phpscript/guardian.php';
const String deleteUrl = 'http://192.168.100.20/phpscript/delete_guardian.php';

Future<List<Guardian>> getData() async {
  final connect = Connect();
  final result = await connect.get(fetchUrl);

  if (result.isSuccess && result.data != null) {
    return result.data!.map((json) => Guardian.fromJson(json)).toList();
  } else {
    throw Exception(result.errorMessage ?? 'Unknown error fetching guardians');
  }
}

Future<void> postDelete(int id) async {
  final connect = Connect();
  final GuardianDeleteRequest request = GuardianDeleteRequest(id);
  final result = await connect.post(deleteUrl, request);

  if (result.isSuccess) {
    Get.snackbar('Success', 'Guardian deleted successfully');
  } else {
    Get.snackbar('Error', 'Failed to delete guardian ${result.errorCode}');
  }
}

class GuardianDataSource extends DataGridSource {
  final DataGridController controller;
  final void Function(DataGridRow row) onShowDetails;
  final Future<void> Function() onRefresh;
  dynamic newCellValue;

  GuardianDataSource({
    required List<Guardian> guardians,
    required int rowsPerPage,
    required this.controller,
    required this.onShowDetails,
    required this.onRefresh,
  }) : _rowsPerPage = rowsPerPage {
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
        DataGridCell<String>(columnName: 'button', value: null),
      ]);
    }).toList(growable: true);
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    bool isSelected = controller.selectedRows.contains(row);

    return DataGridRowAdapter(
      cells: row.getCells().map((cell) {
        if (cell.columnName == 'button') {
          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: GestureDetector(
              child: isSelected
                  ? const Icon(Icons.delete, color: Colors.white)
                  : const Icon(Icons.info, color: Colors.black),
              onTap: () async {
                Get.defaultDialog(
                  title: 'Are you sure you want to delete this guardian?',
                  onConfirm: () async {
                    try {
                      if (isSelected) {
                        try {
                          int id =
                              int.parse(row.getCells()[0].value.toString());
                          await postDelete(id);
                          await onRefresh();
                        } catch (e) {
                          dev.log("Delete error: $e");
                        }
                      } else {
                        onShowDetails(row);
                      }
                    } catch (e) {
                      dev.log("Delete error: $e");
                    }
                    Get.back();
                  },
                  onCancel: () => Get.back(),
                );
              },
            ),
          );
        }
        return Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text(cell.value.toString(), overflow: TextOverflow.ellipsis),
        );
      }).toList(),
    );
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
    }

    return true;
  }
}

class GuardianShow extends StatefulWidget {
  const GuardianShow({super.key});

  @override
  State<GuardianShow> createState() => _GuardianShowState();
}

class _GuardianShowState extends State<GuardianShow> {
  final int _rowsPerPage = 5;
  final double _dataPagerHeight = 60.0;
  late DataGridController _controller;
  late List<Guardian> _guardians;
  late GuardianDataSource _dataSource;
  bool _isLoading = true;
  final GlobalKey<SfDataGridState> key = GlobalKey<SfDataGridState>();

  Future<void> _refreshData() async {
    setState(() => _isLoading = true);
    try {
      _guardians = await getData();

      _dataSource = GuardianDataSource(
        guardians: _guardians,
        rowsPerPage: _rowsPerPage,
        controller: _controller,
        onShowDetails: _showDetails,
        onRefresh: _refreshData,
      );
    } catch (e) {
      dev.log("Failed to load guardians: $e");
      _guardians = []; // Avoid passing null
      Get.snackbar('Error', 'Failed to load guardians');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showDetails(DataGridRow row) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Guardian Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('ID: ${row.getCells()[0].value.toString()}'),
            Text('Last Name: ${row.getCells()[1].value.toString()}'),
            Text('First Name: ${row.getCells()[2].value.toString()}'),
            Text('Date of Birth: ${row.getCells()[3].value.toString()}'),
            Text('Relationship: ${row.getCells()[4].value.toString()}'),
            Text('Email: ${row.getCells()[5].value.toString()}'),
            Text('Phone: ${row.getCells()[6].value.toString()}'),
            Text('Guardian Account: ${row.getCells()[7].value.toString()}'),
            Text('Children: ${row.getCells()[8].value.toString()}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = DataGridController();
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: key,
        appBar: AppBar(title: const Text('Guardians List')),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _guardians.isEmpty
                ? const Center(child: Text("No guardians found."))
                : Column(
                    children: [
                      Expanded(
                        child: SfDataGridTheme(
                          data: SfDataGridThemeData(selectionColor: Colors.red),
                          child: SfDataGrid(
                            controller: _controller,
                            source: _dataSource,
                            columnWidthMode: ColumnWidthMode.fill,
                            navigationMode: GridNavigationMode.cell,
                            allowSorting: true,
                            allowFiltering: true,
                            allowEditing: true,
                            showCheckboxColumn: true,
                            selectionMode: SelectionMode.singleDeselect,
                            gridLinesVisibility: GridLinesVisibility.both,
                            headerGridLinesVisibility: GridLinesVisibility.both,
                            editingGestureType: EditingGestureType.doubleTap,
                            columns: [
                              GridColumn(
                                  allowEditing: false,
                                  columnName: 'id',
                                  label: _buildHeader('ID')),
                              GridColumn(
                                  allowEditing: true,
                                  columnName: 'first_name',
                                  label: _buildHeader('First Name')),
                              GridColumn(
                                  allowEditing: true,
                                  columnName: 'last_name',
                                  label: _buildHeader('Last Name')),
                              GridColumn(
                                  allowEditing: true,
                                  columnName: 'date_of_birth',
                                  label: _buildHeader('DOB')),
                              GridColumn(
                                  allowEditing: true,
                                  columnName: 'relationship',
                                  label: _buildHeader('Relation')),
                              GridColumn(
                                  allowEditing: true,
                                  columnName: 'phone_number',
                                  label: _buildHeader('Phone')),
                              GridColumn(
                                  columnName: 'email',
                                  label: _buildHeader('Email')),
                              GridColumn(
                                  allowEditing: false,
                                  columnName: 'guardian_account',
                                  label: _buildHeader('Account')),
                              GridColumn(
                                  allowEditing: false,
                                  columnName: 'children',
                                  label: _buildHeader('Children')),
                              GridColumn(
                                  allowEditing: false,
                                  allowSorting: false,
                                  allowFiltering: false,
                                  columnName: 'button',
                                  label: _buildHeader('Action')),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: _dataPagerHeight,
                        child: SfDataPager(
                          delegate: _dataSource,
                          pageCount:
                              (_guardians.length / _rowsPerPage).ceilToDouble(),
                        ),
                      ),
                    ],
                  ),
        floatingActionButton: FloatingActionButton(
          onPressed: _refreshData,
          child: const Icon(Icons.refresh),
        ),
      ),
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

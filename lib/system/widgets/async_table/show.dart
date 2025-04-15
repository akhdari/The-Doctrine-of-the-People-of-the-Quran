import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './data_grid_source.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import './data_class.dart';
import 'dart:developer' as dev;
import 'package:syncfusion_flutter_core/theme.dart';

const String url = 'http://192.168.100.20/phpscript/guardian.php';

Future<List<Guardian>> get(String url) async {
  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body) as List<dynamic>;
      var listOfMaps = jsonResponse.cast<Map<String, dynamic>>();
      List<Guardian> guardians =
          listOfMaps.map<Guardian>((json) => Guardian.fromJson(json)).toList();

      return guardians;
    } else {
      throw Exception('Request failed: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error fetching data: $e');
  }
}

Future<void> post(String url, String id) async {
  try {
    final response = await http
        .post(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'id': id}), // send the id as a JSON object
        )
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      dev.log("response: ${response.body}");
    } else {
      throw Exception('Request failed: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error posting data: $e');
  }
}

Future<List<Guardian>> getData() async {
  var data = await get(url);
  return data;
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
  late DataGridCheckboxColumnSettings _checkboxColumnSettings;

  @override
  void initState() {
    super.initState();
    _controller = DataGridController();
    _checkboxColumnSettings = DataGridCheckboxColumnSettings();
    getData().then((value) {
      _guardians = value;
      _dataSource =
          GuardianDataSource(guardians: _guardians, rowsPerPage: _rowsPerPage);
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion DataGrid with Pagination'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {},
          ),
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Expanded(
                    child: SfDataGridTheme(
                      data: SfDataGridThemeData(
                        selectionColor: Color(0xFFFF0000),
                      ),
                      child: SfDataGrid(
                        controller: _controller,
                        source: _dataSource,
                        allowSorting: true,
                        showCheckboxColumn: true,
                        checkboxColumnSettings: _checkboxColumnSettings,
                        onSelectionChanged: (addedRows, removedRows) {
                          setState(() {
                            for (var row in addedRows) {
                              final rowData = {
                                for (var cell in row.getCells())
                                  cell.columnName: cell.value,
                              };
                              dev.log("Selected Row Data: $rowData");
                            }
                          });
                        },

                        allowSwiping: true,
                        swipeMaxOffset: 100,
                        allowFiltering: true,
                        //allowEditing: true,
                        //editingGestureType: EditingGestureType.doubleTap,
                        //checkboxShape: ,
                        //isScrollbarAlwaysShown: true,
                        gridLinesVisibility: GridLinesVisibility.both,
                        headerGridLinesVisibility: GridLinesVisibility.both,
                        selectionMode: SelectionMode.singleDeselect,
                        columns: <GridColumn>[
                          GridColumn(
                            columnName: 'id',
                            columnWidthMode: ColumnWidthMode.fill,
                            label: _buildHeader('ID'),
                          ),
                          GridColumn(
                            columnName: 'first_name',
                            columnWidthMode: ColumnWidthMode.fill,
                            label: _buildHeader('First Name'),
                          ),
                          GridColumn(
                            columnName: 'last_name',
                            columnWidthMode: ColumnWidthMode.fill,
                            label: _buildHeader('Last Name'),
                          ),
                          GridColumn(
                            columnName: 'date_of_birth',
                            columnWidthMode: ColumnWidthMode.fill,
                            label: _buildHeader('Date Of Birth'),
                          ),
                          GridColumn(
                            columnName: 'relationship',
                            columnWidthMode: ColumnWidthMode.fill,
                            label: _buildHeader('Relationship'),
                          ),
                          GridColumn(
                            columnName: 'phone_number',
                            columnWidthMode: ColumnWidthMode.fill,
                            label: _buildHeader('Phone Number'),
                          ),
                          GridColumn(
                            columnName: 'email',
                            columnWidthMode: ColumnWidthMode.fill,
                            label: _buildHeader('Email'),
                          ),
                          GridColumn(
                            columnName: 'guardian_account',
                            columnWidthMode: ColumnWidthMode.fill,
                            label: _buildHeader('Guardian Account'),
                          ),
                          GridColumn(
                            columnName: 'child_account',
                            columnWidthMode: ColumnWidthMode.fill,
                            label: _buildHeader('Children Account'),
                          ),
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
              );
      }),
    ));
  }

  Widget _buildHeader(String title) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.centerLeft,
      child: Text(title, overflow: TextOverflow.ellipsis),
    );
  }
}

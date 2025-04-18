import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'generic_data_source.dart';

class GenericDataGrid<T> extends StatefulWidget {
  final Future<List<T>> Function() dataFetcher;
  final Future<void> Function(int id) onDelete;
  final DataGridRow Function(T model) rowBuilder;
  final List<GridColumn> columns;
  final String Function(DataGridRow row) idExtractor;
  final String screenTitle;
  final String detailsTitle;
  final int rowsPerPage;

  const GenericDataGrid({
    super.key,
    required this.dataFetcher,
    required this.onDelete,
    required this.rowBuilder,
    required this.columns,
    required this.idExtractor,
    this.screenTitle = 'Data Grid',
    this.detailsTitle = 'Item Details',
    this.rowsPerPage = 10,
  });

  @override
  State<GenericDataGrid<T>> createState() => _GenericDataGridState<T>();
}

class _GenericDataGridState<T> extends State<GenericDataGrid<T>> {
  late DataGridController _controller;
  late List<T> _items;
  late GenericDataSource<T> _dataSource;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = DataGridController();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      _items = await widget.dataFetcher();
      _initializeDataSource();
    } catch (e) {
      _items = [];
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _initializeDataSource() {
    _dataSource = GenericDataSource<T>(
      data: _items,
      gridController: _controller,
      onDelete: widget.onDelete,
      onRefresh: _loadData,
      rowBuilder: widget.rowBuilder,
      idExtractor: widget.idExtractor,
      detailsTitle: widget.detailsTitle,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.screenTitle)),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _items.isEmpty
              ? const Center(child: Text("No data found."))
              : Column(
                  children: [
                    Expanded(
                      child: SfDataGridTheme(
                        data: const SfDataGridThemeData(
                          selectionColor: Colors.red,
                        ),
                        child: SfDataGrid(
                          controller: _controller,
                          source: _dataSource,
                          columns: widget.columns,
                          columnWidthMode: ColumnWidthMode.fill,
                          selectionMode: SelectionMode.singleDeselect,
                          allowSorting: true,
                          showCheckboxColumn: true,
                          allowFiltering: true,
                          gridLinesVisibility: GridLinesVisibility.both,
                          headerGridLinesVisibility: GridLinesVisibility.both,
                        ),
                      ),
                    ),
                  ],
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadData,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'generic_data_source.dart';
import 'dart:developer' as dev;

class GenericDataGrid<T> extends StatefulWidget {
  final List<T> data;
  final Future<void> Function(int id)? onDelete;
  final DataGridRow Function(T model) rowBuilder;
  final Widget? Function(DataGridCell cell)? cellBuilder;
  final List<GridColumn> columns;
  final dynamic Function(DataGridRow row) idExtractor;
  final String screenTitle;
  final String detailsTitle;
  final int rowsPerPage;
  final SelectionMode selectionMode;
  final bool showCheckBoxColumn;
  final IconData infoIcon;
  final IconData deleteIcon;
  final Color? selectionColor;
  final Future<void> Function() onRefresh;
  final void Function(DataGridRow? selectedRow)? getDataGridRow;
  final void Function(T? obj)? getObj;

  const GenericDataGrid({
    super.key,
    required this.data,
    required this.onDelete,
    required this.rowBuilder,
    required this.columns,
    required this.idExtractor,
    required this.onRefresh,
    this.cellBuilder,
    this.screenTitle = 'Data Grid',
    this.detailsTitle = 'Item Details',
    this.rowsPerPage = 10,
    this.selectionMode = SelectionMode.singleDeselect,
    this.showCheckBoxColumn = false,
    this.infoIcon = Icons.info_outline,
    this.deleteIcon = Icons.delete,
    this.selectionColor,
    this.getDataGridRow,
    this.getObj,
  });

  @override
  State<GenericDataGrid<T>> createState() => _GenericDataGridState<T>();
}

class _GenericDataGridState<T> extends State<GenericDataGrid<T>> {
  late DataGridController _controller;
  late GenericDataSource<T> _dataSource;

  @override
  void initState() {
    super.initState();
    _controller = DataGridController();
    _initializeDataSource();
  }

  @override
  void didUpdateWidget(GenericDataGrid<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data != widget.data) {
      _initializeDataSource();
    }
  }

  void _initializeDataSource() {
    _dataSource = GenericDataSource<T>(
      data: widget.data,
      gridController: _controller,
      onDelete: widget.onDelete,
      onRefresh: widget.onRefresh,
      rowBuilder: widget.rowBuilder,
      idExtractor: widget.idExtractor,
      detailsTitle: widget.detailsTitle,
      cellBuilder: widget.cellBuilder,
      infoIcon: widget.infoIcon,
      deleteIcon: widget.deleteIcon,
      selectionColor: widget.selectionColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SfDataGridTheme(
            data: SfDataGridThemeData(
              selectionColor:
                  widget.selectionColor ?? Colors.blue.withValues(alpha: 0.1),
            ),
            child: SfDataGrid(
                controller: _controller,
                source: _dataSource,
                columns: widget.columns,
                columnWidthMode: ColumnWidthMode.fill,
                selectionMode: widget.selectionMode,
                showCheckboxColumn: widget.showCheckBoxColumn,
                allowSorting: true,
                allowFiltering: true,
                gridLinesVisibility: GridLinesVisibility.both,
                headerGridLinesVisibility: GridLinesVisibility.both,
                /*
                data grid row is wrapper that wraps the data grid cells 
                and not the original obj 
                */
                //Once it's in the grid, a DataGridRow doesn't have a reference back to its original T
                //we neep a mapping between the DataGridRow and the original T
                onCheckboxValueChanged: (details) {
                  if (details.value == true) {
                    final selectedRow = details.row;
                    if (selectedRow != null) {
                      final rowId = widget.idExtractor(selectedRow);
                      final obj = _dataSource.getModelFromRow(selectedRow);
                      widget.getObj?.call(obj);
                      widget.getDataGridRow?.call(selectedRow);
                      dev.log('Checkbox changed for row ID: $rowId');
                      dev.log('Original model: $obj');
                    } else {
                      dev.log('Checkbox changed for a null row.');
                      widget.getObj?.call(null);
                      widget.getDataGridRow?.call(null);
                    }
                  } else {
                    widget.getObj?.call(null);
                    widget.getDataGridRow?.call(null);
                  }
                }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                mini: true,
                onPressed: widget.onRefresh,
                child: const Icon(Icons.refresh),
              ),
              if (widget.onDelete != null &&
                  _controller.selectedRows.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: FloatingActionButton(
                    mini: true,
                    backgroundColor: Colors.red,
                    onPressed: () {
                      final selectedRow = _controller.selectedRows.first;
                      final id = _dataSource.idExtractor(selectedRow);
                      widget.onDelete?.call(id as int);
                    },
                    child: Icon(widget.deleteIcon),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

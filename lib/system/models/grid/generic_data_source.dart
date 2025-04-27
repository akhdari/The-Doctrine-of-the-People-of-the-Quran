import 'dart:developer' as dev;
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:flutter/material.dart';

class GenericDataSource<T> extends DataGridSource {
  final DataGridController gridController;
  final Future<void> Function(int id)? onDelete;
  final Future<void> Function() onRefresh;
  final DataGridRow Function(T model) rowBuilder;
  final dynamic Function(DataGridRow row) idExtractor;
  final String detailsTitle;
  final Widget? Function(DataGridCell cell)? cellBuilder;
  final IconData infoIcon;
  final IconData deleteIcon;
  final Color? selectionColor;

  GenericDataSource({
    required List<T> data,
    required this.gridController,
    required this.onDelete,
    required this.onRefresh,
    required this.rowBuilder,
    required this.idExtractor,
    this.detailsTitle = 'Item Details',
    this.cellBuilder,
    this.infoIcon = Icons.info_outline,
    this.deleteIcon = Icons.delete,
    this.selectionColor,
  }) {
    _data = data;
    buildDataGridRows();
  }

  List<T> _data = [];
  late List<DataGridRow> _rows;

  @override
  List<DataGridRow> get rows => _rows;

  void updateDataSource(List<T> newData) {
    _data = newData;
    buildDataGridRows();
    notifyListeners();
  }

  void buildDataGridRows() {
    _rows = _data.map<DataGridRow>((e) => rowBuilder(e)).toList();
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final isSelected = gridController.selectedRows.contains(row);
    final cells = row.getCells();

    return DataGridRowAdapter(
      color: isSelected
          ? (selectionColor ?? Colors.blue.withValues(alpha: 0.1))
          : null,
      cells: cells.map<Widget>((cell) {
        if (cell.columnName == 'button') {
          return _buildActionCell(isSelected, row);
        } else {
          return _buildDataCell(cell);
        }
      }).toList(),
    );
  }

  Widget _buildActionCell(bool isSelected, DataGridRow row) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: GestureDetector(
        child: isSelected
            ? Icon(deleteIcon, color: Colors.red)
            : Icon(infoIcon, color: Colors.blue),
        onTap: () => isSelected ? _showDeleteDialog(row) : _showRowDetails(row),
      ),
    );
  }

  Widget _buildDataCell(DataGridCell cell) {
    return cellBuilder?.call(cell) ??
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: Text(
            cell.value?.toString() ?? '',
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12),
          ),
        );
  }

  void _showDeleteDialog(DataGridRow row) {
    Get.defaultDialog(
      title: 'Confirm Deletion',
      content: const Text('Are you sure you want to delete this item?'),
      textConfirm: 'Delete',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      onConfirm: () async {
        try {
          final id = idExtractor(row);
          await onDelete?.call(id);
          await onRefresh();
        } catch (e) {
          dev.log("Delete error: $e");
          Get.snackbar('Error', 'Failed to delete item');
        }
        Get.back();
      },
    );
  }

  void _showRowDetails(DataGridRow row) {
    final details = row
        .getCells()
        .where((c) => c.columnName != 'button')
        .map((cell) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 120,
                    child: Text(
                      '${cell.columnName}:',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      cell.value?.toString() ?? 'N/A',
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ))
        .toList();

    Get.dialog(
      AlertDialog(
        title: Text(detailsTitle),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: details,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

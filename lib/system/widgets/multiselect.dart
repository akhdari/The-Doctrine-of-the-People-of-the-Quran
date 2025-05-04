import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:multiple_search_selection/multiple_search_selection.dart';
import '../services/connect.dart';

class MultiSelectResult {
  List<MultiSelectItem>? items;
  String? errorMessage;
  MultiSelectResult.onSuccess({required this.items}) : errorMessage = null;
  MultiSelectResult.onError({required this.errorMessage}) : items = null;
}

class MultiSelectItem {
  final int id;
  final String name;

  MultiSelectItem({required this.id, required this.name});

  factory MultiSelectItem.fromJson(Map<String, dynamic> json) {
    return MultiSelectItem(
      id: int.parse(json['id']),
      name: json['name'] as String,
    );
  }
}

Future<MultiSelectResult> getItems(String url) async {
  Connect connect = Connect();
  ApiResult<List<Map<String, dynamic>>> data;

  List<Map<String, dynamic>> items;
  List<MultiSelectItem> teacherList;
  data = await connect.get(url);
  if (data.isSuccess) {
    items = data.data!;

    teacherList = items.map((item) => MultiSelectItem.fromJson(item)).toList();
    return MultiSelectResult.onSuccess(items: teacherList);
  } else {
    return MultiSelectResult.onError(errorMessage: data.errorMessage);
  }
}

class MultiSelect extends StatefulWidget {
  final List<MultiSelectItem> preparedData;
  final Function(List<MultiSelectItem>) getPickedItems;
  final String hintText;
  final int? maxSelectedItems;

  const MultiSelect({
    super.key,
    required this.getPickedItems,
    required this.preparedData,
    required this.hintText,
    required this.maxSelectedItems,
  });

  @override
  State<MultiSelect> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  late final MultipleSearchController _multipleSearchController;
  List<MultiSelectItem> _pickedItems = [];

  @override
  void initState() {
    super.initState();
    _multipleSearchController = MultipleSearchController(
      allowDuplicateSelection: false,
      isSelectable: true,
      minCharsToShowItems: 1,
    );
    dev.log('MultiSelect initialized with ${widget.preparedData.length} items');
  }

  List<MultiSelectItem> get pickedItems {
    return _multipleSearchController.getPickedItems().cast<MultiSelectItem>();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        MultipleSearchSelection<MultiSelectItem>.overlay(
          controller: _multipleSearchController,
          maxSelectedItems: widget.maxSelectedItems,
          clearSearchFieldOnSelect: true,
          searchField: TextField(
            decoration: InputDecoration(
              hintText: widget.hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          items: widget.preparedData, // Use the data list
          fieldToCheck: (item) => item.name, // Use 'name' to filter
          sortPickedItems: true,
          sortShowedItems: true,
          onTapClearAll: () {
            _multipleSearchController.clearSearchField();
            dev.log(
                'Show all items | Picked: ${_pickedItems.map((e) => e.name)}');
          },
          onTapSelectAll: () {
            _multipleSearchController.selectAllItemsCallback;
            dev.log(
                'Show all items | Picked: ${_pickedItems.map((e) => e.name)}');
          },

          onItemAdded: (item) {
            _multipleSearchController.getPickedItemsCallback;

            dev.log(
                'Added: ${item.name} | Picked: ${_pickedItems.map((e) => e.name)}');
          },
          onItemRemoved: (item) {
            _multipleSearchController.getPickedItemsCallback;

            dev.log(
                'Removed: ${item.name} | Picked: ${_pickedItems.map((e) => e.name)}');
          },
          itemBuilder: (item, index, isPicked) => Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: isPicked
                    ? colorScheme.primaryContainer
                    : colorScheme.surface,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                child: Text(
                  item.name, // Show the name of the item
                  style: textTheme.bodySmall,
                ),
              ),
            ),
          ),
          clearAllButton: Text(
            'Clear All',
            style: textTheme.bodySmall?.copyWith(color: colorScheme.primary),
          ),
          selectAllButton: Text(
            'Select All',
            style: textTheme.bodySmall?.copyWith(color: colorScheme.primary),
          ),
          noResultsWidget: ListTile(
            title: Text(
              'No results found',
              style: TextStyle(color: colorScheme.onSurface),
            ),
          ),
          pickedItemBuilder: (item) => Container(
            margin: const EdgeInsets.only(right: 4),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              border: Border.all(color: colorScheme.outline),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.name,
                    style: textTheme.bodySmall,
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.close,
                    size: 16,
                    color: colorScheme.onSurface,
                  ),
                ],
              ),
            ),
          ),
          maximumShowItemsHeight: 200,
        ),
      ],
    );
  }
}

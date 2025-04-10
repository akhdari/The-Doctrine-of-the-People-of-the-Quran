import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:multiple_search_selection/multiple_search_selection.dart';

class DefaultConstructorExample extends StatefulWidget {
  final MultipleSearchController multipleSearchController;
  final List<Map<String, dynamic>> preparedData;
  late dynamic pickedItems;
  final String searchkey;
  final String hintText;
  final int? maxSelectedItems;

  DefaultConstructorExample({
    super.key,
    required this.multipleSearchController,
    required this.preparedData,
    required this.pickedItems,
    required this.searchkey,
    required this.hintText,
    required this.maxSelectedItems,
  });

  @override
  State<DefaultConstructorExample> createState() =>
      _DefaultConstructorExampleState();
}

class _DefaultConstructorExampleState extends State<DefaultConstructorExample> {
  TextEditingController searchController = TextEditingController();

  List<String> get listedData => widget.preparedData
      .map((dataItem) => dataItem[widget.searchkey].toString())
      .toList();

  List<String>? pickedItems;

  @override
  void dispose() {
    // Don't dispose the searchController here - it's managed by the parent
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MultipleSearchSelection.overlay(
          controller: widget.multipleSearchController,
          maxSelectedItems: widget.maxSelectedItems,
          searchField: TextField(
            decoration: InputDecoration(
              hintText: widget.hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  searchController.clear();
                  widget.multipleSearchController.clearSearchField();
                },
                icon: const Icon(Icons.clear),
              ),
            ),
          ),
          onSearchChanged: (text) {
            log('Search text: $text');
          },
          itemsVisibility: ShowedItemsVisibility.onType,
          clearSearchFieldOnSelect: true,
          items: listedData,
          fieldToCheck: (item) => item,
          onItemAdded: (c) {
            widget.multipleSearchController.getAllItems().length;
            widget.multipleSearchController.getPickedItems().length;
          },
          onItemRemoved: (item) {
            log('Item removed: $item');
          },
          itemBuilder: (item, index, isPicked) {
            return Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: isPicked ? Colors.blue[100] : Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 12,
                  ),
                  child: Text(item),
                ),
              ),
            );
          },
          pickedItemBuilder: (item) {
            return Container(
              margin: const EdgeInsets.only(right: 4),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                border: Border.all(color: Colors.blue[200]!),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(item),
                    const SizedBox(width: 4),
                    Icon(Icons.close, size: 16),
                  ],
                ),
              ),
            );
          },
          sortShowedItems: true,
          sortPickedItems: true,
          selectAllButton: Padding(
            padding: const EdgeInsets.all(12.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Select All'),
              ),
            ),
          ),
          clearAllButton: Padding(
            padding: const EdgeInsets.all(12.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Clear All'),
              ),
            ),
          ),
          caseSensitiveSearch: false,
          fuzzySearch: FuzzySearch.none,
          showSelectAllButton: true,
          maximumShowItemsHeight: 200,
        ),
        const SizedBox(height: 8),
        /* ElevatedButton(
          onPressed: _confirmSelection,
          child: const Text('Confirm Selection'),
        ),*/
      ],
    );
  }

  /* _confirmSelection() {
    if (widget.multipleSearchController.getPickedItems().isNotEmpty) {
      //.cast<T>() converts a List of dynamic or unknown types into a List<T> by casting each element.
      widget.pickedItems =
          widget.multipleSearchController.getPickedItems().cast<String>();
      if (widget.pickedItems != null) {
        widget.pickedItems = widget.pickedItems!.length == 1
            ? widget.pickedItems![0]
            : widget.pickedItems;
      }
      log('Confirmed picked items: $widget.pickedItems');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Selected ${widget.pickedItems!.length} items')),
      );
    } else {
      log('No items selected');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one item')),
      );
    }
  }*/
}

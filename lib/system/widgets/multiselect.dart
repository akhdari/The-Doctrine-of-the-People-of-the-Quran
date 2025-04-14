import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:multiple_search_selection/multiple_search_selection.dart';

class DefaultConstructorExample extends StatefulWidget {
  final List<Map<String, dynamic>> preparedData;
  final Function(List<String>) getPickedItems;
  final String searchkey;
  final String hintText;
  final int? maxSelectedItems;

  const DefaultConstructorExample({
    super.key,
    // required this.multipleSearchController,
    required this.getPickedItems,
    required this.preparedData,
    required this.searchkey,
    required this.hintText,
    required this.maxSelectedItems,
  });

  @override
  State<DefaultConstructorExample> createState() =>
      _DefaultConstructorExampleState();
}

class _DefaultConstructorExampleState extends State<DefaultConstructorExample> {
  late MultipleSearchController multipleSearchController;
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    multipleSearchController = MultipleSearchController(
      allowDuplicateSelection: false,
      isSelectable: true,
      minCharsToShowItems: 1,
    );
    searchController = TextEditingController();
  }

  List<String> pickedItems = [];
  void _updatePickedItems(List<String> newPickedItems) {
    pickedItems = newPickedItems;
  }

  List<String> get listedData => widget.preparedData
      .map((dataItem) => dataItem[widget.searchkey].toString())
      .toList();

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
          controller:
              multipleSearchController, //widget.multipleSearchController
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
                  // widget.multipleSearchController.clearSearchField();
                },
                icon: const Icon(Icons.clear),
              ),
            ),
          ),
          onSearchChanged: (text) {
            dev.log('Search text: $text');
          },
          itemsVisibility: ShowedItemsVisibility.onType,
          clearSearchFieldOnSelect: true,
          items: listedData,
          fieldToCheck: (item) => item,
          onItemAdded: (c) {
            // widget.multipleSearchController.getAllItems().length;
            // widget.multipleSearchController.getPickedItems().length;
            dev.log('c: $c');
            // dev.log(multipleSearchController.getAllItems().length.toString());

            pickedItems.add(c);
            _updatePickedItems(pickedItems);
            widget.getPickedItems(pickedItems);
            dev.log('Picked items: $pickedItems');

            // dev.log(
            // 'All items: ${widget.multipleSearchController.getAllItems()}');
            //dev.log(
            //'Item added: ${widget.multipleSearchController.getPickedItems()}');
          },
          onItemRemoved: (c) {
            dev.log('Item removed: $c');
            pickedItems.remove(c);
            _updatePickedItems(pickedItems);
            widget.getPickedItems(pickedItems);
            dev.log('Picked items: $pickedItems');
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
          caseSensitiveSearch: false,
          fuzzySearch: FuzzySearch.none,
          showSelectAllButton: true,
          maximumShowItemsHeight: 200,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

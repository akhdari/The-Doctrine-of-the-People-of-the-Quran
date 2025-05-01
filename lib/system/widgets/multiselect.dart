import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:multiple_search_selection/multiple_search_selection.dart';

class MultiSelect<T> extends StatefulWidget {
  final List<T> preparedData;
  final Function(List<String>) getPickedItems;
  final String hintText;
  final int? maxSelectedItems;
  final String Function(T) itemAsString;

  const MultiSelect({
    super.key,
    required this.getPickedItems,
    required this.preparedData,
    required this.hintText,
    required this.maxSelectedItems,
    required this.itemAsString,
  });

  @override
  State<MultiSelect<T>> createState() => _MultiSelectState<T>();
}

class _MultiSelectState<T> extends State<MultiSelect<T>> {
  //late final TextEditingController _searchController;
  late final MultipleSearchController _multipleSearchController;
  final List<String> _pickedItems = [];

  @override
  void initState() {
    super.initState();
    //_searchController = TextEditingController();
    _multipleSearchController = MultipleSearchController(
      allowDuplicateSelection: false,
      isSelectable: true,
      minCharsToShowItems: 1,
    );
  }

  void _updatePickedItems(List<String> newPickedItems) {
    widget.getPickedItems(newPickedItems);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MultipleSearchSelection<T>.overlay(
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
          items: widget.preparedData,
          fieldToCheck: (item) => widget.itemAsString(item),
          onItemAdded: (item) {
            final display = widget.itemAsString(item);
            _pickedItems.add(display);
            _updatePickedItems(_pickedItems);
            dev.log('Added: $display | Picked: $_pickedItems');
          },
          onItemRemoved: (item) {
            final display = widget.itemAsString(item);
            _pickedItems.remove(display);
            _updatePickedItems(_pickedItems);
            dev.log('Removed: $display | Picked: $_pickedItems');
          },
          itemBuilder: (item, index, isPicked) => Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: isPicked ? Colors.blue[100] : Colors.white,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                child: Text(widget.itemAsString(item)),
              ),
            ),
          ),
          pickedItemBuilder: (item) => Container(
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
                  Text(widget.itemAsString(item)),
                  const SizedBox(width: 4),
                  const Icon(Icons.close, size: 16),
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

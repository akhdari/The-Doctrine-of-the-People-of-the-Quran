import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:multiple_search_selection/multiple_search_selection.dart';

class MultiSelect<T> extends StatefulWidget {
  final List<T> preparedData;
  final Function(List<String>) getPickedItems;
  final String hintText;
  final int? maxSelectedItems;
  final String Function(T) itemAsString;
  final List<int>? initialSelectedIds;

  const MultiSelect({
    super.key,
    required this.getPickedItems,
    required this.preparedData,
    required this.hintText,
    required this.maxSelectedItems,
    required this.itemAsString,
    this.initialSelectedIds,
  });

  @override
  State<MultiSelect<T>> createState() => _MultiSelectState<T>();
}

class _MultiSelectState<T> extends State<MultiSelect<T>> {
  late final MultipleSearchController _multipleSearchController;
  final List<String> _pickedItems = [];

  @override
  void initState() {
    super.initState();
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
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
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
                color: isPicked
                    ? colorScheme.primaryContainer
                    : colorScheme.surface,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                child: Text(
                  widget.itemAsString(item),
                  style: textTheme.bodySmall,
                ),
              ),
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
                    widget.itemAsString(item),
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

  @override
  void didUpdateWidget(MultiSelect<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialSelectedIds != null &&
        widget.initialSelectedIds != oldWidget.initialSelectedIds) {
      // Clear existing selections
      _pickedItems.clear();

      // Select initial items
      for (var id in widget.initialSelectedIds!) {
        final item = widget.preparedData.firstWhere(
          (element) => element.toString() == id.toString(),
          orElse: () => null as T,
        );
        if (item != null) {
          final display = widget.itemAsString(item);
          _pickedItems.add(display);
        }
      }
      _updatePickedItems(_pickedItems);
    }
  }
}

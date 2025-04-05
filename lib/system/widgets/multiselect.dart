import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:multiple_search_selection/multiple_search_selection.dart';
import './constants.dart';

class DefaultConstructorExample extends StatelessWidget {
  const DefaultConstructorExample({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MultipleSearchController<Country> controller = MultipleSearchController(
      minCharsToShowItems: 1,
      allowDuplicateSelection: false,
    );
    return Scaffold(
      body: Column(
        children: [
          MultipleSearchSelection.overlay(
            searchField: TextField(
              decoration: InputDecoration(
                hintText: 'Search countries',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                suffixIcon: IconButton(
                  onPressed: controller.clearSearchField,
                  icon: const Icon(
                    Icons.clear,
                  ),
                ),
              ),
            ),
            onSearchChanged: (text) {
              log('Text is $text');
            },
            controller: controller,
            itemsVisibility: ShowedItemsVisibility.onType,
            title: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Countries',
                style: kStyleDefault.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onItemAdded: (c) {
              controller.getAllItems().length;
              controller.getPickedItems().length;
            },
            clearSearchFieldOnSelect: true,
            items: countries, // List<Country>
            fieldToCheck: (c) {
              return c.name;
            },
            itemBuilder: (country, index, isPicked) {
              return Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 12,
                    ),
                    child: Text(country.name),
                  ),
                ),
              );
            },
            pickedItemBuilder: (country) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[400]!),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(country.name),
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
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Select All',
                    style: kStyleDefault,
                  ),
                ),
              ),
            ),
            clearAllButton: Padding(
              padding: const EdgeInsets.all(12.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Clear All',
                    style: kStyleDefault,
                  ),
                ),
              ),
            ),
            caseSensitiveSearch: false,
            fuzzySearch: FuzzySearch.none,
            showSelectAllButton: true,
            maximumShowItemsHeight: 200,
          ),
          TextButton(
            onPressed: () {
              controller.getPickedItems();
              controller.getPickedItems().isEmpty;
            },
            child: const Text('press'),
          ),
        ],
      ),
    );
  }
}

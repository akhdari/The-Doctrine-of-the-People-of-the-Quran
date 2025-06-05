import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../stats/date_picker.dart'; // Import the custom date picker
import 'dart:developer' as dev;

class ChartFilterController extends GetxController {
  final String tag;
  final lectureNameController = TextEditingController();
  final studentNameController = TextEditingController();

  final fromDate = Rxn<DateTime>();
  final toDate = Rxn<DateTime>();
  final isFilterApplied = false.obs;
  final isLoading = false.obs;

  ChartFilterController({required this.tag});

  @override
  void onInit() {
    super.onInit();
    _setDefaultDates();
  }

  void _setDefaultDates() {
    final now = DateTime.now();
    final previousMonth = now.month == 1 ? 12 : now.month - 1;
    final year = now.month == 1 ? now.year - 1 : now.year;

    fromDate.value = DateTime(
      year,
      previousMonth,
      1,
    ); // First day of previous month
    toDate.value = DateTime(
      year,
      previousMonth + 1,
      0,
    ); // Last day of previous month
  }

  bool canApply() {
    if (fromDate.value == null || toDate.value == null) {
      Get.snackbar('Error', "Please select both date ranges");
      return false;
    }

    if (fromDate.value!.isAfter(toDate.value!)) {
      Get.snackbar('Error', "Start date must be before end date");
      return false;
    }

    return true;
  }

  Future<void> pickDate(BuildContext context, {required bool isFrom}) async {
    final initialDate =
        (isFrom ? fromDate.value : toDate.value) ?? DateTime.now();
    final firstDate = DateTime(2000);
    final lastDate = DateTime(2030);

    final selectedDate = await showCustomDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: isFrom ? firstDate : (fromDate.value ?? firstDate),
      lastDate: isFrom ? (toDate.value ?? lastDate) : lastDate,
    );

    dev.log("Selected date: $selectedDate");
    if (selectedDate != null) {
      if (isFrom) {
        fromDate.value = selectedDate;
      } else {
        toDate.value = selectedDate;
      }
    }
  }

  void applyFilters() {
    if (canApply()) {
      isFilterApplied.value = true;
    }
  }

  void resetFilters() {
    lectureNameController.clear();
    studentNameController.clear();
    _setDefaultDates();
    isFilterApplied.value = false;
  }

  String get formattedFromDate =>
      fromDate.value != null
          ? DateFormat('yyyy-MM-dd').format(fromDate.value!)
          : '';

  String get formattedToDate =>
      fromDate.value != null
          ? DateFormat('yyyy-MM-dd').format(toDate.value!)
          : '';

  @override
  void onClose() {
    lectureNameController.dispose();
    studentNameController.dispose();
    super.onClose();
  }
}

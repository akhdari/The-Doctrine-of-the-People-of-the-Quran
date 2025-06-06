import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/models/post/guardian.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/api_client.dart';

import 'dart:developer' as dev;

class GuardianController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<GuardianInfoDialog> guardianList = <GuardianInfoDialog>[].obs;
  RxString errorMessage = ''.obs;

  Future<void> getData(String fetchUrl, {VoidCallback? onFinished}) async {
    try {
      errorMessage.value = '';
      final result = await ApiService.fetchList<GuardianInfoDialog>(
          fetchUrl, GuardianInfoDialog.fromMap);

      if (result.isNotEmpty) {
        guardianList.value = result;
        dev.log('Guardians fetched successfully: ${guardianList.length}');
      } else {
        errorMessage.value = 'Unknown error fetching guardians';
        guardianList.clear();
      }
    } catch (e) {
      errorMessage.value =
          'Failed to connect to server. Please check your connection.';
      guardianList.clear();
    } finally {
      onFinished?.call();
    }
  }

//
  Future<void> postDelete(int id) async {
    try {
      Get.snackbar('Success', 'Guardian deleted successfully');
    } catch (e) {
      dev.log('Exception during deletion: $e');
      Get.snackbar('Error', 'Failed to delete guardian ${e.toString()}');
    }
  }
}

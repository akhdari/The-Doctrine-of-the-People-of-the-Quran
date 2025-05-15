import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '/system/services/connect.dart';
import '/system/models/delete/guardian.dart';
import '/system/models/get/guardian_class.dart';
import 'dart:developer' as dev;

class GuardianController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<Guardian> guardianList = <Guardian>[].obs;
  RxString errorMessage = ''.obs;

  Future<void> getData(String fetchUrl, {VoidCallback? onFinished}) async {
    try {
      errorMessage.value = '';
      final connect = Connect();
      final result = await connect.get(fetchUrl);
      dev.log(
          'API result: isSuccess=${result.isSuccess}, data=${result.data}, error=${result.errorMessage}');

      if (result.isSuccess && result.data != null) {
        guardianList.value =
            result.data!.map((json) => Guardian.fromJson(json)).toList();
        dev.log('Guardians fetched successfully: ${guardianList.length}');
      } else {
        errorMessage.value =
            result.errorMessage ?? 'Unknown error fetching guardians';
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
  Future<void> postDelete(int id, String deleteUrl) async {
    try {
      dev.log('Attempting to delete guardian with ID: $id');
      dev.log('Using URL: $deleteUrl');

      final connect = Connect();
      final request = GuardianDeleteRequest(id);
      dev.log('Request body: ${request.toMap()}');

      final result = await connect.post(deleteUrl, request);
      dev.log('Response: ${result.toString()}');

      if (result.isSuccess) {
        dev.log('Deletion successful');
        Get.snackbar('Success', 'Guardian deleted successfully');
      } else {
        dev.log('Deletion failed with error: ${result.errorCode}');
        Get.snackbar('Error', 'Failed to delete guardian ${result.errorCode}');
      }
    } catch (e) {
      dev.log('Exception during deletion: $e');
      Get.snackbar('Error', 'Failed to connect to server');
    }
  }
}

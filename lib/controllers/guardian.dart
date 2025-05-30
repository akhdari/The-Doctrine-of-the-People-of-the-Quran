import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/connect.dart';
import '/system/services/network/api_endpoints.dart';
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
  Future<void> postDelete(int id) async {
    try {
      final connect = Connect();
      final result = await connect.delete(ApiEndpoints.getGuardianById(id));
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

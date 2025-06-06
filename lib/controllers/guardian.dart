import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/models/post/guardian.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/api_client.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/utils/snackbar_helper.dart';

import 'dart:developer' as dev;

/// Controller for managing a list of Guardians, with loading, error, and deletion logic.
class GuardianController extends GetxController {
  // Observable loading state
  RxBool isLoading = true.obs;

  // Observable list of fetched guardians
  RxList<GuardianInfoDialog> guardianList = <GuardianInfoDialog>[].obs;

  // Observable error message to display in UI
  RxString errorMessage = ''.obs;

  /// Fetch data from the given URL and update the guardian list
  Future<void> getData(
    String fetchUrl, {
    VoidCallback? onFinished,
    BuildContext? context, // Optional: pass if you want to show snackbar
  }) async {
    try {
      errorMessage.value = '';
      final result = await ApiService.fetchList<GuardianInfoDialog>(
        fetchUrl,
        GuardianInfoDialog.fromMap,
      );

      if (result.isNotEmpty) {
        guardianList.value = result;
        dev.log('Guardians fetched successfully: ${guardianList.length}');
      } else {
        errorMessage.value = 'تعذر جلب البيانات من الخادم.';
        guardianList.clear();
        if (context != null) {
          showInfoSnackbar(context, 'لم يتم العثور على بيانات.');
        }
      }
    } catch (e) {
      errorMessage.value = 'فشل الاتصال بالخادم. تحقق من اتصالك.';
      guardianList.clear();
      if (context != null) {
        showErrorSnackbar(context, 'فشل الاتصال بالخادم.');
      }
    } finally {
      onFinished?.call();
    }
  }

  /// Handle deletion of a guardian (with simulated logic).
  Future<void> postDelete(int id, BuildContext context) async {
    try {
      // TODO: Implement actual API deletion logic here
      // await ApiService.deleteItem('your-endpoint/$id');

      showSuccessSnackbar(context, 'تم حذف الولي بنجاح.');
    } catch (e) {
      dev.log('Exception during deletion: $e');
      showErrorSnackbar(context, 'فشل حذف الولي. حاول مرة أخرى.');
    }
  }
}

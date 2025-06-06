import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/models/post/lecture.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/api_client.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/network/api_endpoints.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/utils/snackbar_helper.dart';

/// Controller for managing lectures list, loading state, and deletion
class LectureController extends GetxController {
  // State observables
  RxBool isLoading = false.obs;
  RxList<LectureForm> lectureList = <LectureForm>[].obs;
  RxString errorMessage = ''.obs;

  /// Fetches list of lectures from API
  Future<void> getData(
    String fetchUrl, {
    VoidCallback? onFinished,
    BuildContext? context,
  }) async {
    try {
      errorMessage.value = '';
      final result = await ApiService.fetchList<LectureForm>(
        fetchUrl,
        (json) => LectureForm.fromJson(json),
      );

      if (result.isNotEmpty) {
        lectureList.value = result;
      } else {
        errorMessage.value = 'تعذر جلب المحاضرات.';
        lectureList.clear();
        if (context != null) {
          showInfoSnackbar(context, 'لا توجد محاضرات متاحة حالياً.');
        }
      }
    } catch (e) {
      errorMessage.value = 'فشل الاتصال بالخادم. تحقق من الاتصال بالإنترنت.';
      lectureList.clear();
      if (context != null) {
        showErrorSnackbar(context, 'حدث خطأ أثناء تحميل المحاضرات.');
      }
    } finally {
      onFinished?.call();
    }
  }

  /// Deletes a lecture and refreshes the list
  Future<void> postDelete(int id, BuildContext context) async {
    try {
      // TODO: Replace with actual delete request if API supports it
      // await ApiService.deleteItem('lecture-endpoint/$id');

      // Show success message and refresh
      showSuccessSnackbar(context, 'تم حذف المحاضرة بنجاح.');
      await getData(ApiEndpoints.getLectures, context: context);
    } catch (e) {
      showErrorSnackbar(context, 'فشل حذف المحاضرة. حاول لاحقاً.');
    }
  }
}

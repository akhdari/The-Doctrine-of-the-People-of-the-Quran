import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/models/post/lecture.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/api_client.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/network/api_endpoints.dart';

/// Controller for managing lectures list, loading state, and deletion
class LectureController extends GetxController {
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
      }
    } catch (e) {
      errorMessage.value = e is NoNetworkException
          ? 'لا يوجد اتصال بالإنترنت.'
          : 'فشل الاتصال بالخادم. تحقق من الاتصال بالإنترنت.';
      lectureList.clear();
    } finally {
      onFinished?.call();
    }
  }

  /// Deletes a lecture and refreshes the list
  Future<void> postDelete(int id) async {
    try {
      await ApiService.delete(ApiEndpoints.getLectureById(id));
      await getData(ApiEndpoints.getLectures);
    } catch (_) {
      errorMessage.value = 'فشل حذف المحاضرة. حاول لاحقاً.';
    }
  }
}

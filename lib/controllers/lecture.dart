import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/models/post/lecture.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/api_client.dart';
import '/system/services/network/api_endpoints.dart';

class LectureController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<LectureForm> lectureList = <LectureForm>[].obs;
  RxString errorMessage = ''.obs;

  Future<void> getData(String fetchUrl, {VoidCallback? onFinished}) async {
    try {
      errorMessage.value = '';
      final result = await ApiService.fetchList<LectureForm>(
          fetchUrl, (json) => LectureForm.fromJson(json));

      if (result.isNotEmpty) {
        lectureList.value = result;
      } else {
        errorMessage.value = 'Unknown error fetching lectures';
        lectureList.clear();
      }
    } catch (e) {
      errorMessage.value =
          'Failed to connect to server. Please check your connection.';
      lectureList.clear();
    } finally {
      onFinished?.call();
    }
  }

  Future<void> postDelete(int id) async {
    try {
      Get.snackbar('Success', 'Lecture deleted successfully');
      await getData(ApiEndpoints.getLectures); // optional: auto-refresh
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete lecture ${e.toString()}');
    }
  }
}

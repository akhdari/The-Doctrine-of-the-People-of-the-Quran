import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '/system/services/network/api_endpoints.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/connect.dart';
import '/system/models/get/lecture_class.dart';

class LectureController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<Lecture> lectureList = <Lecture>[].obs;
  RxString errorMessage = ''.obs;

  Future<void> getData(String fetchUrl, {VoidCallback? onFinished}) async {
    try {
      errorMessage.value = '';
      final connect = Connect();
      final result = await connect.get(fetchUrl);

      if (result.isSuccess && result.data != null) {
        lectureList.value =
            result.data!.map((json) => Lecture.fromJson(json)).toList();
      } else {
        errorMessage.value =
            result.errorMessage ?? 'Unknown error fetching lectures';
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
      final connect = Connect();
      final result = await connect.delete(ApiEndpoints.getLectureById(id));

      if (result.isSuccess) {
        Get.snackbar('Success', 'Lecture deleted successfully');
        await getData(ApiEndpoints.getLectures); // optional: auto-refresh
      } else {
        Get.snackbar('Error', 'Failed to delete lecture ${result.errorCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to connect to server');
    }
  }
}

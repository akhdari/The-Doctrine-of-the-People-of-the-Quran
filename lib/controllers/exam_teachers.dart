import 'package:get/get.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/models/post/exam_teachers.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/api_client.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/network/api_endpoints.dart';
import 'package:flutter/material.dart';

class ExamTeacherController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<ExamTeacherInfoDialog> teachersList = <ExamTeacherInfoDialog>[].obs;
  RxString errorMessage = ''.obs;

  Future<void> getData(String fetchUrl, {VoidCallback? onFinished}) async {
    try {
      errorMessage.value = '';
      final result = await ApiService.fetchList<ExamTeacherInfoDialog>(
          fetchUrl, (ExamTeacherInfoDialog.fromMap));
      if (result.isEmpty) {
        errorMessage.value = 'No Exam teacher found';
      } else {
        errorMessage.value = '';
        teachersList.value = result;
      }
    } catch (e) {
      errorMessage.value =
          'Failed to connect to server. Please check your connection.';
      teachersList.clear();
    } finally {
      onFinished?.call(); // Wait for timer before turning off loading
    }
  }

  Future<void> postDelete(int id) async {
    try {
      await ApiService.delete(ApiEndpoints.getStudentById(id));
    } catch (e) {
      Get.snackbar('Error', 'Failed to connect to server');
    }
  }
}

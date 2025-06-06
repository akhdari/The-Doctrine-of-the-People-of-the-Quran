import 'package:get/get.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/exam.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/api_client.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/network/api_endpoints.dart';
import 'package:flutter/material.dart';

class ExamTypesController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<Exam> examList = <Exam>[].obs;
  RxString errorMessage = ''.obs;

  Future<void> getData(String fetchUrl, {VoidCallback? onFinished}) async {
    try {
      errorMessage.value = '';
      final result =
          await ApiService.fetchList<Exam>(fetchUrl, (Exam.fromJson));
      if (result.isEmpty) {
        errorMessage.value = 'No Exam type found';
      } else {
        errorMessage.value = '';
        examList.value = result;
      }
    } catch (e) {
      errorMessage.value =
          'Failed to connect to server. Please check your connection.';
      examList.clear();
    } finally {
      onFinished?.call(); // Wait for timer before turning off loading
    }
  }

  Future<void> postDelete(int id) async {
    try {
      await ApiService.delete(ApiEndpoints.getExamById(id));
    } catch (e) {
      Get.snackbar('Error', 'Failed to connect to server');
    }
  }
}

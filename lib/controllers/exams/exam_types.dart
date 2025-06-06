import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/exam.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/api_client.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/network/api_endpoints.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/utils/snackbar_helper.dart';

class ExamTypesController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxList<Exam> examList = <Exam>[].obs;
  final RxString errorMessage = ''.obs;

  /// Fetch all exam types from server
  Future<void> getData(String fetchUrl, {VoidCallback? onFinished}) async {
    try {
      errorMessage.value = '';
      final result = await ApiService.fetchList<Exam>(
        fetchUrl,
        Exam.fromJson,
      );

      if (result.isEmpty) {
        errorMessage.value = 'لم يتم العثور على أنواع الامتحانات';
        examList.clear();
      } else {
        examList.value = result;
      }
    } catch (e) {
      errorMessage.value =
          'فشل الاتصال بالخادم. يرجى التحقق من الاتصال بالإنترنت.';
      examList.clear();
      showErrorSnackbar(Get.context!, errorMessage.value);
    } finally {
      onFinished?.call(); // Stop loading animation after completion
    }
  }

  /// Delete exam type by ID
  Future<void> postDelete(int id) async {
    try {
      await ApiService.delete(ApiEndpoints.getExamById(id));
      showSuccessSnackbar(Get.context!, 'تم حذف نوع الامتحان بنجاح');
    } catch (e) {
      showErrorSnackbar(Get.context!, 'فشل في حذف نوع الامتحان');
    }
  }
}

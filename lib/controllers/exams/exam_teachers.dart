import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/models/post/exam_teachers.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/api_client.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/network/api_endpoints.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/utils/snackbar_helper.dart';

class ExamTeacherController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxList<ExamTeacherInfoDialog> teachersList =
      <ExamTeacherInfoDialog>[].obs;
  final RxString errorMessage = ''.obs;

  /// Fetch exam teachers from the server
  Future<void> fetchExamTeachers(String fetchUrl,
      {VoidCallback? onFinished}) async {
    try {
      errorMessage.value = '';
      final result = await ApiService.fetchList<ExamTeacherInfoDialog>(
        fetchUrl,
        ExamTeacherInfoDialog.fromMap,
      );

      if (result.isEmpty) {
        errorMessage.value = 'لم يتم العثور على معلمي الامتحان';
        teachersList.clear();
      } else {
        teachersList.value = result;
      }
    } catch (e) {
      errorMessage.value =
          'فشل الاتصال بالخادم. يرجى التحقق من الاتصال بالإنترنت.';
      teachersList.clear();
      showErrorSnackbar(Get.context!, errorMessage.value);
    } finally {
      onFinished?.call(); // Called after fetching finishes
    }
  }

  /// Delete exam teacher by ID
  Future<void> deleteExamTeacher(int id) async {
    try {
      await ApiService.delete(
          ApiEndpoints.getStudentById(id)); // Consider renaming endpoint
      showSuccessSnackbar(Get.context!, 'تم حذف معلم الامتحان بنجاح');
    } catch (e) {
      showErrorSnackbar(Get.context!, 'فشل في حذف معلم الامتحان');
    }
  }
}

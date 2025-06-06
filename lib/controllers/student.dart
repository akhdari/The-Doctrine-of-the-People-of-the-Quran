import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/models/post/student.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/api_client.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/network/api_endpoints.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/utils/snackbar_helper.dart';

/// Controller for managing students data and deletion operations
class StudentController extends GetxController {
  // Observable loading state
  RxBool isLoading = true.obs;

  // List of students
  RxList<StudentInfoDialog> studentList = <StudentInfoDialog>[].obs;

  // Error message (if any)
  RxString errorMessage = ''.obs;

  /// Fetch student list from API
  Future<void> getData(
    String fetchUrl, {
    VoidCallback? onFinished,
    BuildContext? context,
  }) async {
    try {
      errorMessage.value = '';
      final result = await ApiService.fetchList<StudentInfoDialog>(
        fetchUrl,
        StudentInfoDialog.fromJson,
      );

      if (result.isEmpty) {
        errorMessage.value = 'لم يتم العثور على طلاب.';
        if (context != null) {
          showInfoSnackbar(context, 'لا توجد بيانات طلاب حالياً.');
        }
      } else {
        studentList.value = result;
      }
    } catch (e) {
      errorMessage.value = 'فشل الاتصال بالخادم. تحقق من الاتصال.';
      studentList.clear();
      if (context != null) {
        showErrorSnackbar(context, 'فشل تحميل الطلاب.');
      }
    } finally {
      onFinished?.call(); // Optional callback (e.g. stop loading)
    }
  }

  /// Delete a student from server by ID and refresh the list
  Future<void> postDelete(int id, BuildContext context) async {
    try {
      await ApiService.delete(ApiEndpoints.getStudentById(id));

      showSuccessSnackbar(context, 'تم حذف الطالب بنجاح.');
      await getData(ApiEndpoints.getStudents, context: context); // Refresh list
    } catch (e) {
      showErrorSnackbar(context, 'فشل حذف الطالب. حاول مرة أخرى.');
    }
  }
}

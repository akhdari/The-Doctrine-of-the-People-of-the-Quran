import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/appreciation.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/api_client.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/network/api_endpoints.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/utils/snackbar_helper.dart';

class ExamNotesController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxList<Appreciation> examNotes = <Appreciation>[].obs;
  final RxString errorMessage = ''.obs;

  /// Fetches exam notes data from the API
  Future<void> fetchExamNotes(String url, {VoidCallback? onFinished}) async {
    try {
      errorMessage.value = '';
      final result = await ApiService.fetchList<Appreciation>(
        url,
        Appreciation.fromJson,
      );

      if (result.isEmpty) {
        errorMessage.value = 'لم يتم العثور على ملاحظات امتحان';
        examNotes.clear();
      } else {
        examNotes.value = result;
      }
    } catch (e) {
      errorMessage.value =
          'فشل الاتصال بالخادم. يرجى التحقق من الاتصال بالإنترنت.';
      examNotes.clear();
      showErrorSnackbar(Get.context!, errorMessage.value);
    } finally {
      onFinished?.call();
    }
  }

  /// Deletes an exam note by ID
  Future<void> deleteExamNote(int id) async {
    try {
      await ApiService.delete(ApiEndpoints.getStudentById(id));
      showSuccessSnackbar(Get.context!, 'تم حذف الملاحظة بنجاح');
    } catch (e) {
      showErrorSnackbar(Get.context!, 'فشل في حذف الملاحظة');
    }
  }
}

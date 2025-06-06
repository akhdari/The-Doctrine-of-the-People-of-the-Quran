import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/models/post/exam_records.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/api_client.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/network/api_endpoints.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/utils/snackbar_helper.dart';

class ExamRecordController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxList<ExamRecordInfoDialog> recordsList = <ExamRecordInfoDialog>[].obs;
  final RxString errorMessage = ''.obs;

  /// Fetch exam records from server
  Future<void> fetchExamRecords(String fetchUrl,
      {VoidCallback? onFinished}) async {
    try {
      errorMessage.value = '';
      final result = await ApiService.fetchList<ExamRecordInfoDialog>(
        fetchUrl,
        ExamRecordInfoDialog.fromMap,
      );

      if (result.isEmpty) {
        errorMessage.value = 'لم يتم العثور على سجلات امتحان';
        recordsList.clear();
      } else {
        recordsList.value = result;
      }
    } catch (e) {
      errorMessage.value =
          'فشل الاتصال بالخادم. يرجى التحقق من الاتصال بالإنترنت.';
      recordsList.clear();
      showErrorSnackbar(Get.context!, errorMessage.value);
    } finally {
      onFinished?.call(); // Called after data fetching finishes
    }
  }

  /// Delete exam record by ID
  Future<void> deleteExamRecord(int id) async {
    try {
      await ApiService.delete(ApiEndpoints.getStudentById(id));
      showSuccessSnackbar(Get.context!, 'تم حذف سجل الامتحان بنجاح');
    } catch (e) {
      showErrorSnackbar(Get.context!, 'فشل في حذف سجل الامتحان');
    }
  }
}

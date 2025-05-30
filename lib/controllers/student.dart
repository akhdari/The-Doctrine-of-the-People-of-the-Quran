import 'package:get/get.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/network/api_endpoints.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/connect.dart';
import '/system/models/get/student_class.dart';
import 'package:flutter/material.dart';

class StudentController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<Student> studentList = <Student>[].obs;
  RxString errorMessage = ''.obs;

  Future<void> getData(String fetchUrl, {VoidCallback? onFinished}) async {
    try {
      errorMessage.value = '';
      final connect = Connect();
      final result = await connect.get(fetchUrl);

      if (result.isSuccess && result.data != null) {
        studentList.value =
            result.data!.map((json) => Student.fromJson(json)).toList();
      } else {
        errorMessage.value =
            result.errorMessage ?? 'Unknown error fetching students';
        studentList.clear();
      }
    } catch (e) {
      errorMessage.value =
          'Failed to connect to server. Please check your connection.';
      studentList.clear();
    } finally {
      onFinished?.call(); // Wait for timer before turning off loading
    }
  }

  Future<void> postDelete(int id) async {
    try {
      final connect = Connect();

      final result = await connect.delete(ApiEndpoints.getStudentById(id));

      if (result.isSuccess) {
        Get.snackbar('Success', 'Student deleted successfully');
      } else {
        Get.snackbar('Error', 'Failed to delete student ${result.errorCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to connect to server');
    }
  }
}

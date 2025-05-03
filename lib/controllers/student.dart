import 'package:get/get.dart';
import '/system/services/connect.dart';
import '/system/models/delete/student.dart';
import '/system/models/get/student_class.dart';

class StudentController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<Student> studentList = <Student>[].obs;
  RxString errorMessage = ''.obs;

  Future<void> getData(String fetchUrl) async {
    try {
      isLoading.value = true;
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
      isLoading.value = false;
    }
  }

  Future<void> postDelete(int id, String deleteUrl) async {
    try {
      final connect = Connect();
      final request = StudentDeleteRequest(id);
      final result = await connect.post(deleteUrl, request);

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

import 'package:get/get.dart';
import '/system/services/connect.dart';
import '/system/models/delete/student.dart';
import '/system/models/get/student_class.dart';

class StudentController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<Student> studentList = <Student>[].obs;

  Future<void> getData(String fetchUrl) async {
    final connect = Connect();
    final result = await connect.get(fetchUrl);

    if (result.isSuccess && result.data != null) {
      isLoading.value = false;
      studentList.value =
          result.data!.map((json) => Student.fromJson(json)).toList();
    } else {
      isLoading.value = false;
      throw Exception(result.errorMessage ?? 'Unknown error fetching students');
    }
  }

  Future<void> postDelete(int id, String deleteUrl) async {
    final connect = Connect();
    final request = StudentDeleteRequest(id);
    final result = await connect.post(deleteUrl, request);

    if (result.isSuccess) {
      Get.snackbar('Success', 'student deleted successfully');
    } else {
      Get.snackbar('Error', 'Failed to delete student ${result.errorCode}');
    }
  }
}

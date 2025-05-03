import 'package:get/get.dart';
import '/system/services/connect.dart';
import '/system/models/delete/lecture.dart';
import '/system/models/get/lecture_class.dart';

class LectureController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<Lecture> lectureList = <Lecture>[].obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getData('http://192.168.100.20/phpscript/lecture.php');
  }

  Future<void> getData(String fetchUrl) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final connect = Connect();
      final result = await connect.get(fetchUrl);

      if (result.isSuccess && result.data != null) {
        lectureList.value =
            result.data!.map((json) => Lecture.fromJson(json)).toList();
      } else {
        errorMessage.value =
            result.errorMessage ?? 'Unknown error fetching lectures';
        lectureList.clear();
      }
    } catch (e) {
      errorMessage.value =
          'Failed to connect to server. Please check your connection.';
      lectureList.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> postDelete(int id, String deleteUrl) async {
    try {
      final connect = Connect();
      final request = LectureDeleteRequest(id);
      final result = await connect.post(deleteUrl, request);

      if (result.isSuccess) {
        Get.snackbar('Success', 'Lecture deleted successfully');
        getData(
            'http://192.168.100.20/phpscript/lecture.php'); // Refresh the list after deletion
      } else {
        Get.snackbar('Error', 'Failed to delete lecture ${result.errorCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to connect to server');
    }
  }
}

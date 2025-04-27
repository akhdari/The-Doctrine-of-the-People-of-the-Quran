import 'package:get/get.dart';
import '/system/services/connect.dart';
import '/system/models/delete/lecture.dart';
import '/system/models/get/lecture_class.dart';

class LectureController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<Lecture> lectureList = <Lecture>[].obs;

  Future<void> getData(String fetchUrl) async {
    final connect = Connect();
    final result = await connect.get(fetchUrl);

    if (result.isSuccess && result.data != null) {
      isLoading.value = false;
      lectureList.value =
          result.data!.map((json) => Lecture.fromJson(json)).toList();
    } else {
      isLoading.value = false;
      throw Exception(
          result.errorMessage ?? 'Unknown error fetching guardians');
    }
  }

  Future<void> postDelete(int id, String deleteUrl) async {
    final connect = Connect();
    final request = LectureDeleteRequest(id);
    final result = await connect.post(deleteUrl, request);

    if (result.isSuccess) {
      Get.snackbar('Success', 'Guardian deleted successfully');
    } else {
      Get.snackbar('Error', 'Failed to delete guardian ${result.errorCode}');
    }
  }
}

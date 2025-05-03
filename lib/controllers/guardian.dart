import 'package:get/get.dart';
import '/system/services/connect.dart';
import '/system/models/delete/guardian.dart';
import '/system/models/get/guardian_class.dart';

class GuardianController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<Guardian> guardianList = <Guardian>[].obs;
  RxString errorMessage = ''.obs;

  Future<void> getData(String fetchUrl) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final connect = Connect();
      final result = await connect.get(fetchUrl);

      if (result.isSuccess && result.data != null) {
        guardianList.value =
            result.data!.map((json) => Guardian.fromJson(json)).toList();
      } else {
        errorMessage.value =
            result.errorMessage ?? 'Unknown error fetching guardians';
        guardianList.clear();
      }
    } catch (e) {
      errorMessage.value =
          'Failed to connect to server. Please check your connection.';
      guardianList.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> postDelete(int id, String deleteUrl) async {
    try {
      final connect = Connect();
      final request = GuardianDeleteRequest(id);
      final result = await connect.post(deleteUrl, request);

      if (result.isSuccess) {
        Get.snackbar('Success', 'Guardian deleted successfully');
      } else {
        Get.snackbar('Error', 'Failed to delete guardian ${result.errorCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to connect to server');
    }
  }
}

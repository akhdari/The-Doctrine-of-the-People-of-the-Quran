import 'package:get/get.dart';
import '/system/services/connect.dart';
import '/system/models/get/acheivement_class.dart';

import 'dart:developer' as dev;

const String partialUrl =
    "http://192.168.100.20/phpscript/acheivement_student_list.php?session_id=";

class AchievementController extends GetxController {
  RxnInt lectureId = RxnInt();
  RxString date = ''.obs;
  RxList<Acheivement> achievementList = <Acheivement>[].obs;
  RxBool isLoading = true.obs;
  RxBool isrequestCompleted = false.obs;
  RxString errorMessage = ''.obs;

  void setLectureId(int? id) {
    if (id == null) return;
    lectureId.value = id;
    fetchData();
  }

  void setDate(String newDate) {
    date.value = newDate;
  }

  Future<void> fetchData() async {
    isLoading.value = true;
    errorMessage.value = '';
    final connect = Connect();
    final result = await connect.get("$partialUrl${lectureId.value}");
    dev.log(result.toString());
    if (result.isSuccess && result.data != null) {
      isLoading.value = false;
      isrequestCompleted.value = true;
      achievementList.value =
          result.data!.map((json) => Acheivement.fromJson(json)).toList();
    } else {
      isLoading.value = false;
      isrequestCompleted.value = true;
      errorMessage.value =
          result.errorMessage ?? 'Unknown error fetching students';
    }
  }
}

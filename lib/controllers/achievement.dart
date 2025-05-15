import 'package:get/get.dart';
import '/system/services/connect.dart';
import '/system/models/get/acheivement_class.dart';
import 'dart:developer' as dev;
import '/system/services/network/api_endpoints.dart';
import 'package:flutter/material.dart';

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

  Future<void> fetchData({VoidCallback? onFinished}) async {
    errorMessage.value = '';
    final connect = Connect();

    try {
      final result = await connect
          .get(ApiEndpoints.getStudentsByLecture(lectureId.value!));
      dev.log(result.toString());

      if (result.isSuccess && result.data != null) {
        isrequestCompleted.value = true;
        achievementList.value =
            result.data!.map((json) => Acheivement.fromJson(json)).toList();
      } else {
        isrequestCompleted.value = true;
        errorMessage.value =
            result.errorMessage ?? 'Unknown error fetching students';
      }
    } catch (e) {
      isrequestCompleted.value = true;
      errorMessage.value =
          'Failed to connect to server. Please check your connection.';
    } finally {
      onFinished?.call();
    }
  }
}

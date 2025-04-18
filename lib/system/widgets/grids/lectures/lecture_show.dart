import 'package:flutter/material.dart';
import 'lecture.dart'; // your LectureGrid widget
import '../../../models/get/lecture_class.dart'; // contains Lecture model
import '../../../services/connect.dart';
import '../../../models/delete/lecture.dart'; // your lecture delete request class
import 'package:get/get.dart';

const String fetchUrl = 'http://192.168.100.20/phpscript/lecture.php';
const String deleteUrl = 'http://192.168.100.20/phpscript/delete_lecture.php';

class LectureScreen extends StatelessWidget {
  const LectureScreen({super.key});

/*************  ✨ Windsurf Command ⭐  *************/
  /// Fetches all lectures from the database.
  ///
  /// Returns a list of [Lecture] if the request is successful, otherwise
  /// throws an [Exception] with the error message from the server.
/*******  91a4d942-da65-4f18-93c9-71a2f78e97cf  *******/
  Future<List<Lecture>> getData() async {
    final connect = Connect();
    final result = await connect.get(fetchUrl);

    if (result.isSuccess && result.data != null) {
      return result.data!.map((json) => Lecture.fromJson(json)).toList();
    } else {
      throw Exception(result.errorMessage ?? 'Unknown error fetching lectures');
    }
  }

  Future<void> postDelete(int id) async {
    final connect = Connect();
    final request = LectureDeleteRequest(id);
    final result = await connect.post(deleteUrl, request);

    if (result.isSuccess) {
      Get.snackbar('Success', 'Lecture deleted successfully');
    } else {
      Get.snackbar('Error', 'Failed to delete lecture ${result.errorCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return LectureGrid(
      dataFetcher: getData,
      onDelete: postDelete,
    );
  }
}

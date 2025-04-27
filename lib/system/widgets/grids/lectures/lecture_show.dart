import 'package:flutter/material.dart';
import 'lecture.dart'; // your LectureGrid widget
import '../../../models/get/lecture_class.dart'; // contains Lecture model
import '../../../services/connect.dart';
import '../../../models/delete/lecture.dart'; // your lecture delete request class
import 'package:get/get.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/dialogs/lecture.dart';
import '/controllers/validator.dart';

const String fetchUrl = 'http://192.168.100.20/phpscript/lecture.php';
const String deleteUrl = 'http://192.168.100.20/phpscript/delete_lecture.php';

class LectureScreen extends StatelessWidget {
  const LectureScreen({super.key});
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
    return Column(
      children: [
        Row(
          children: [
            IconButton(
                icon: const Icon(Icons.add, color: Colors.black),
                onPressed: () {
                  Get.put(Validator(2), tag: "lecturePage");
                  Get.dialog(LectureDialog());
                }),
          ],
        ),
        Expanded(
          child: LectureGrid(
            dataFetcher: getData,
            onDelete: postDelete,
          ),
        ),
      ],
    );
  }
}

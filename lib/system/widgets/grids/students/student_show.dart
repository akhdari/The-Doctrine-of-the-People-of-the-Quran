import 'package:flutter/material.dart';
import 'student.dart';
import '../../../models/get/student_class.dart';
import '../../../services/connect.dart';
import '../../../models/delete/student.dart'; // your lecture delete request class
import 'package:get/get.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/dialogs/student.dart';
import '/controllers/generate.dart';
import '/controllers/validator.dart';

const String fetchUrl = 'http://192.168.100.20/phpscript/student.php';
const String deleteUrl = 'http://192.168.100.20/phpscript/delete_student.php';

class StudentScreen extends StatelessWidget {
  const StudentScreen({super.key});

  Future<List<Student>> getData() async {
    final connect = Connect();
    final result = await connect.get(fetchUrl);

    if (result.isSuccess && result.data != null) {
      return result.data!.map((json) => Student.fromJson(json)).toList();
    } else {
      throw Exception(result.errorMessage ?? 'Unknown error fetching students');
    }
  }

  Future<void> postDelete(int id) async {
    final connect = Connect();
    final request = StudentDeleteRequest(id);
    final result = await connect.post(deleteUrl, request);

    if (result.isSuccess) {
      Get.snackbar('Success', 'student deleted successfully');
    } else {
      Get.snackbar('Error', 'Failed to delete student ${result.errorCode}');
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
                Get.put(Validator(16), tag: "studentPage");
                Get.put(Generate());
                Get.dialog(StudentDialog());
              },
            ),
          ],
        ),
        Expanded(
          child: StudentGrid(
            dataFetcher: getData,
            onDelete: postDelete,
          ),
        ),
      ],
    );
  }
}

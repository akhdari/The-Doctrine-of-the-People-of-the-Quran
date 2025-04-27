import 'package:flutter/material.dart';
import 'student.dart';
import 'package:get/get.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/dialogs/student.dart';
import '/controllers/generate.dart';
import '/controllers/validator.dart';
import '/controllers/student.dart';

const String fetchUrl = 'http://192.168.100.20/phpscript/student.php';
const String deleteUrl = 'http://192.168.100.20/phpscript/delete_student.php';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  late StudentController controller;
  @override
  void initState() {
    super.initState();
    controller = Get.find<StudentController>();
    controller.getData(fetchUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (controller.studentList.isEmpty) {
        return const Center(child: Text('No data found'));
      } else {
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
                data: controller.studentList,
                onRefresh: () => controller.getData(fetchUrl),
                onDelete: (id) => controller.postDelete(id, deleteUrl),
              ),
            ),
          ],
        );
      }
    });
  }
}

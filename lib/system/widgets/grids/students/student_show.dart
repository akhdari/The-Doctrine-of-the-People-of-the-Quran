import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../dialogs/student.dart';
import '../../../../controllers/validator.dart';
import '../../../../controllers/generate.dart';
import '../../../../controllers/student.dart';
import 'student.dart';
import '../../error_illustration.dart';

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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.add, color: Colors.black),
                onPressed: () {
                  Get.put(Validator(16), tag: "studentPage");
                  Get.put(Generate());
                  Get.dialog(StudentDialog())
                      .then((_) => controller.getData(fetchUrl));
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.errorMessage.value.isNotEmpty) {
              return ErrorIllustration(
                illustrationPath: 'assets/illustration/bad-connection.svg',
                title: 'Connection Error',
                message: controller.errorMessage.value,
                onRetry: () => controller.getData(fetchUrl),
              );
            }

            if (controller.studentList.isEmpty) {
              return ErrorIllustration(
                illustrationPath: 'assets/illustration/empty-box.svg',
                title: 'No Students Found',
                message:
                    'There are no students registered yet. Click the add button to create one.',
              );
            }

            return StudentGrid(
              data: controller.studentList,
              onRefresh: () => controller.getData(fetchUrl),
              onDelete: (id) => controller.postDelete(id, deleteUrl),
            );
          }),
        ),
      ],
    );
  }
}

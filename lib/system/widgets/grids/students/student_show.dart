import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/network/api_endpoints.dart';
import '../../dialogs/student.dart';
import '../../../../controllers/generate.dart';
import '../../../../controllers/student.dart';
import 'student.dart';
import '../../error_illustration.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/three_bounce.dart';
import '/controllers/form_controller.dart' as form;

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  Duration duration = const Duration(seconds: 5);
  bool minimumLoadTimeCompleted = false;
  late StudentController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<StudentController>();
    _loadData();
  }

  void _loadData() {
    controller.isLoading.value = true;

    Future.wait([
      Future.delayed(duration),
      controller.getData(ApiEndpoints.getStudents),
    ]).then((_) {
      if (mounted) {
        //why check if mounted? bcs the method is being called in the init state method + the future method
        // and bcs it is async by the time the 2 future methods are completed the widget might be disposed
        controller.isLoading.value = false;
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    Get.delete<StudentController>();
    super.dispose();
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
                  Get.put(form.FormController(14));
                  Get.put(Generate());
                  Get.dialog(StudentDialog());
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: Obx(() {
            if (controller.isLoading.value) {
              return Center(child: ThreeBounce());
            }

            if (controller.errorMessage.value.isNotEmpty) {
              return ErrorIllustration(
                illustrationPath: 'assets/illustration/bad-connection.svg',
                title: 'Connection Error',
                message: controller.errorMessage.value,
                onRetry: _loadData,
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
              onRefresh: () {
                _loadData();
                return controller.getData(ApiEndpoints.getStudents);
              },
              onDelete: (id) => controller.postDelete(id),
            );
          }),
        ),
      ],
    );
  }
}

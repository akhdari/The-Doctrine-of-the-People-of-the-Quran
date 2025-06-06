import 'dart:async';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/controllers/edit_student.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/models/post/student.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/api_client.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/network/api_endpoints.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/management_buttons_menu.dart';
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

  final Rxn<StudentInfoDialog> student = Rxn<StudentInfoDialog>();
  final Duration delay = const Duration(seconds: 5);
  late EditStudent editStudentController;
  final RxBool hasSelection = false.obs;

  @override
  void initState() {
    super.initState();
    controller = Get.find<StudentController>();
    _loadData();

    if (!Get.isRegistered<EditStudent>()) {
      editStudentController = Get.put(EditStudent(
        initialLecture: null,
        isEdit: false,
      ));
    } else {
      editStudentController = Get.find<EditStudent>();
    }
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
            child: Obx(
              () => TopButtons(
                onAdd: () {
                  if (Get.isRegistered<EditStudent>()) {
                    hasSelection.value = false;
                    student.value = null;
                    Get.delete<EditStudent>();
                  }
                  Get.put(form.FormController(14));
                  Get.put(Generate());
                  Get.dialog(StudentDialog());
                },
                onEdit: () {
                  if (student.value != null) {
                    Get.put(form.FormController(14));
                    Get.put(Generate());
                    editStudentController.updateLecture(student.value!);
                    editStudentController.isEdit = true;
                    Get.dialog(StudentDialog());
                  }
                },
                onDelete: () async {
                  if (student.value == null) {
                    Get.snackbar('Error', 'No student selected for deletion');
                    return;
                  }

                  await ApiService.delete(ApiEndpoints.getAccountInfoById(
                      student.value!.accountInfo.accountId ?? 0));
                  setState(() {
                    student.value = null;
                    hasSelection.value = false;
                    _loadData();
                  });
                },
                hasSelection: hasSelection.value,
              ),
            )),
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
                onDelete: (id) => controller.postDelete(id, context),
                getObj: (obj) {
                  if (obj != null) {
                    dev.log('Selected lecture: $obj');
                    hasSelection.value = true;
                    student.value = obj;
                  } else {
                    dev.log('Deselected lecture');
                    hasSelection.value = false;
                    student.value = null;
                  }
                });
          }),
        ),
      ],
    );
  }
}

/*// lib/system/widgets/dialogs/student_show.dart
import 'dart:async';
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
import '../../error_illustration.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/three_bounce.dart';
import '/controllers/form_controller.dart' as form;
import 'student.dart'; // path to your StudentGrid

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  static const int kFormControllerCount = 15;
  final Duration delay = const Duration(seconds: 5);

  late StudentController controller;
  final Rxn<StudentInfoDialog> student = Rxn<StudentInfoDialog>();
  late EditStudent editStudentController;
  final RxBool hasSelection = false.obs;

  @override
  void initState() {
    super.initState();
    controller = Get.find<StudentController>();
    _loadData();
    _initializeEditController();
  }

  void _initializeEditController() {
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
      Future.delayed(delay),
      controller.getData(ApiEndpoints.getStudents),
    ]).then((_) {
      if (mounted) controller.isLoading.value = false;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    Get.delete<StudentController>();
    super.dispose();
  }

  Widget _buildErrorWidget() {
    if (controller.errorMessage.value.isNotEmpty) {
      return ErrorIllustration(
        illustrationPath: 'assets/illustration/bad-connection.svg',
        title: 'Connection Error',
        message: controller.errorMessage.value,
        onRetry: _loadData,
      );
    }

    return ErrorIllustration(
      illustrationPath: 'assets/illustration/empty-box.svg',
      title: 'No Students Found',
      message:
          'There are no students registered yet. Click the add button to create one.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => TopButtons(
              onAdd: _handleAdd,
              onEdit: _handleEdit,
              onDelete: _handleDelete,
              hasSelection: hasSelection.value,
            ),
          ),
        ),
        Expanded(
          child: Obx(() {
            if (controller.isLoading.value)
              return const Center(child: ThreeBounce());
            if (controller.errorMessage.value.isNotEmpty ||
                controller.studentList.isEmpty) {
              return _buildErrorWidget();
            }
            return _buildStudentGrid();
          }),
        ),
      ],
    );
  }

  void _handleAdd() {
    if (Get.isRegistered<EditStudent>()) {
      hasSelection.value = false;
      student.value = null;
      Get.delete<EditStudent>();
    }
    Get.put(form.FormController(kFormControllerCount));
    Get.put(Generate());
    Get.dialog(const StudentDialog());
  }

  void _handleEdit() {
    if (student.value != null) {
      Get.put(form.FormController(kFormControllerCount));
      Get.put(Generate());
      editStudentController.updateLecture(student.value!);
      editStudentController.isEdit = true;
      Get.dialog(const StudentDialog());
    }
  }

  Future<void> _handleDelete() async {
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
  }

  Widget _buildStudentGrid() {
    return StudentGrid(
      data: controller.studentList,
      onRefresh: () {
        _loadData();
        return controller.getData(ApiEndpoints.getStudents);
      },
      onDelete: (id) => controller.postDelete(id, context),
      getObj: (obj) {
        if (obj != null) {
          hasSelection.value = true;
          student.value = obj;
        } else {
          hasSelection.value = false;
          student.value = null;
        }
      },
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../dialogs/lecture.dart';
import '../../../../controllers/validator.dart';
import '../../../../controllers/generate.dart';
import '../../../../controllers/lecture.dart';
import 'lecture.dart';
import '../../error_illustration.dart';

class LectureShow extends StatelessWidget {
  final String fetchUrl;
  final String deleteUrl;
  final LectureController controller;

  const LectureShow({
    super.key,
    required this.fetchUrl,
    required this.deleteUrl,
    required this.controller,
  });

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
                  Get.put(Validator(10), tag: "lecturePage");
                  Get.put(Generate());
                  Get.dialog(LectureDialog())
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

            if (controller.lectureList.isEmpty) {
              return ErrorIllustration(
                illustrationPath: 'assets/illustration/empty-box.svg',
                title: 'No Lectures Found',
                message:
                    'There are no lectures registered yet. Click the add button to create one.',
              );
            }

            return LectureGrid(
              data: controller.lectureList,
              onRefresh: () => controller.getData(fetchUrl),
              onDelete: (id) => controller.postDelete(id, deleteUrl),
            );
          }),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'acheivement.dart';
import 'package:get/get.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/controllers/achievement.dart';
import '../../error_illustration.dart';
import 'dart:developer' as dev;

const String partialUrl =
    "http://192.168.100.20/phpscript/acheivement_student_list.php?session_id=";

class AcheivementScreen extends StatefulWidget {
  final RxnInt id;
  final String date;

  const AcheivementScreen({super.key, required this.id, required this.date});

  @override
  State<AcheivementScreen> createState() => _AcheivementScreenState();
}

class _AcheivementScreenState extends State<AcheivementScreen> {
  late AchievementController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<AchievementController>();
    dev.log("id in initState: ${widget.id.value}");
    ever(widget.id, (_) {
      dev.log("id in ever: ${widget.id.value}");
      controller.setLectureId(widget.id.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Show select lecture illustration when no lecture is selected
      if (controller.lectureId.value == null) {
        return ErrorIllustration(
          illustrationPath: 'assets/illustration/select.svg',
          title: 'Select a Lecture',
          message: 'Please select a lecture to view student achievements.',
        );
      }

      // Show loading indicator while fetching data
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      // Show error illustration if there's a connection error
      if (controller.errorMessage.value.isNotEmpty) {
        return ErrorIllustration(
          illustrationPath: 'assets/illustration/bad-connection.svg',
          title: 'Connection Error',
          message: controller.errorMessage.value,
          onRetry: () => controller.fetchData(),
        );
      }

      // Show empty state illustration when no data is found
      if (controller.achievementList.isEmpty &&
          controller.isrequestCompleted.value) {
        return ErrorIllustration(
          illustrationPath: 'assets/illustration/empty-box.svg',
          title: 'No Achievements Found',
          message: 'There are no achievements recorded for this lecture yet.',
        );
      }

      // Show the achievement grid when data is available
      return AcheivementGrid(
        data: controller.achievementList.toList(),
        date: widget.date,
        sessionId: widget.id.value!,
        onRefresh: () => controller.fetchData(),
      );
    });
  }
}

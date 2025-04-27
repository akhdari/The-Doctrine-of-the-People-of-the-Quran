import 'package:flutter/material.dart';
import 'acheivement.dart';
import 'package:get/get.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/controllers/achievement.dart';
import 'dart:developer' as dev;

const String partialUrl =
    "http://192.168.100.20/phpscript/acheivement_student_list.php?session_id=";

class AcheivementScreen extends StatefulWidget {
  final RxnInt id;
  const AcheivementScreen({super.key, required this.id});

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
      if (controller.lectureId.value == null) {
        return const Center(child: Text('Select lecture first'));
      }
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.achievementList.isEmpty) {
        return const Center(child: Text('No data found'));
      }
      return AcheivementGrid(
        data: controller.achievementList.toList(),
        onRefresh: () => controller.fetchData(),
      );
    });
  }
}

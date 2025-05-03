import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/grids/lectures/lecture_show.dart';
import 'system_ui.dart';
import '../../controllers/lecture.dart';

class AddLecture extends StatelessWidget {
  const AddLecture({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LectureController>();
    return Scaffold(
      body: SystemUI(
        title: "Lectures Management",
        child: LectureShow(
          fetchUrl: 'http://192.168.100.20/phpscript/lecture.php',
          deleteUrl: 'http://192.168.100.20/phpscript/delete_lecture.php',
          controller: controller,
        ),
      ),
    );
  }
}

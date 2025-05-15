import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/network/api_endpoints.dart';
import '../widgets/grids/lectures/lecture_show.dart';
import 'system_ui.dart';
import '../../controllers/lecture.dart';

class AddLecture extends StatelessWidget {
  const AddLecture({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LectureController>();
    final theme = Theme.of(context);
    final scaffoldBackgroundColor = theme.scaffoldBackgroundColor;
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: SystemUI(
        title: "Lectures Management",
        child: LectureShow(
          fetchUrl: ApiEndpoints.getLectures,
          deleteUrl: ApiEndpoints.deleteLecture,
          controller: controller,
        ),
      ),
    );
  }
}

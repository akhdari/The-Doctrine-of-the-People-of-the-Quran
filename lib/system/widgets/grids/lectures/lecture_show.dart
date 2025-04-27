import 'package:flutter/material.dart';
import 'lecture.dart'; // your LectureGrid widget
import 'package:get/get.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/dialogs/lecture.dart';
import '/controllers/validator.dart';
import '/controllers/lecture.dart';

const String fetchUrl = 'http://192.168.100.20/phpscript/lecture.php';
const String deleteUrl = 'http://192.168.100.20/phpscript/delete_lecture.php';

class LectureScreen extends StatefulWidget {
  const LectureScreen({super.key});

  @override
  State<LectureScreen> createState() => _LectureScreenState();
}

class _LectureScreenState extends State<LectureScreen> {
  late LectureController controller;
  @override
  void initState() {
    super.initState();
    controller = Get.find<LectureController>();
    controller.getData(fetchUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (controller.lectureList.isEmpty) {
        return const Center(child: Text('No data found'));
      } else {
        return Column(
          children: [
            Row(
              children: [
                IconButton(
                    icon: const Icon(Icons.add, color: Colors.black),
                    onPressed: () {
                      Get.put(Validator(2), tag: "lecturePage");
                      Get.dialog(LectureDialog());
                    }),
              ],
            ),
            Expanded(
              child: LectureGrid(
                data: controller.lectureList.toList(),
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

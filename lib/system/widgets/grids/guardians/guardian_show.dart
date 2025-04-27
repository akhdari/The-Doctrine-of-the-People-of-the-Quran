import 'package:flutter/material.dart';
import 'guardian.dart'; // path to your GuardianGrid
import 'package:get/get.dart';
import '/controllers/validator.dart';
import '/controllers/generate.dart';
import '/controllers/guardian.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/dialogs/guardian.dart';

const String fetchUrl = 'http://192.168.100.20/phpscript/guardian.php';
const String deleteUrl = 'http://192.168.100.20/phpscript/delete_guardian.php';

class GuardianScreen extends StatefulWidget {
  const GuardianScreen({super.key});

  @override
  State<GuardianScreen> createState() => _GuardianScreenState();
}

class _GuardianScreenState extends State<GuardianScreen> {
  late GuardianController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<GuardianController>();
    controller.getData(fetchUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (controller.guardianList.isEmpty) {
        return const Center(child: Text('No data found'));
      } else {
        return Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Get.put(
                      Validator(10),
                      tag: "guardianPage",
                    );
                    Get.put(Generate());
                    Get.dialog(GuardianDialog());
                  },
                )
              ],
            ),
            Expanded(
              child: GuardianGrid(
                data: controller.guardianList,
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

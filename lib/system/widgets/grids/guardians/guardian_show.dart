import 'package:flutter/material.dart';
import 'guardian.dart'; // path to your GuardianGrid
import 'package:get/get.dart';
import '/controllers/validator.dart';
import '/controllers/generate.dart';
import '/controllers/guardian.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/dialogs/guardian.dart';
import '../../error_illustration.dart';

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
  void dispose() {
    super.dispose();
    controller.dispose();
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
                  Get.put(Validator(10), tag: "guardianPage");
                  Get.put(Generate());
                  Get.dialog(GuardianDialog())
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

            if (controller.guardianList.isEmpty) {
              return ErrorIllustration(
                illustrationPath: 'assets/illustration/empty-box.svg',
                title: 'No Guardians Found',
                message:
                    'There are no guardians registered yet. Click the add button to create one.',
              );
            }

            return GuardianGrid(
              data: controller.guardianList,
              onRefresh: () => controller.getData(fetchUrl),
              onDelete: (id) => controller.postDelete(id, deleteUrl),
            );
          }),
        ),
      ],
    );
  }
}

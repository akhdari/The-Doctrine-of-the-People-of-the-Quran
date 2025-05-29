import 'package:flutter/material.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/network/api_endpoints.dart';
import 'guardian.dart'; // path to your GuardianGrid
import 'package:get/get.dart';
import '/controllers/generate.dart';
import '/controllers/guardian.dart';
import '/controllers/form_controller.dart' as form;
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/dialogs/guardian.dart';
import '../../error_illustration.dart';
import 'dart:async';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/three_bounce.dart';

class GuardianScreen extends StatefulWidget {
  const GuardianScreen({super.key});

  @override
  State<GuardianScreen> createState() => _GuardianScreenState();
}

class _GuardianScreenState extends State<GuardianScreen> {
  late GuardianController controller;
  Duration duration = const Duration(seconds: 5);
  bool minimumLoadTimeCompleted = false;

  void _loadData() {
    controller.isLoading.value = true;

    Future.wait([
      Future.delayed(duration),
      controller.getData(ApiEndpoints.getGuardians),
    ]).then((_) {
      if (mounted) {
        controller.isLoading.value = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    controller = Get.find<GuardianController>();
    _loadData();
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
                  Get.put(form.FormController(10));
                  Get.put(Generate());
                  Get.dialog(GuardianDialog());
                  // .then((_) => controller.getData(fetchUrl));
                },
              ),
            ],
          ),
        ),
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

            if (controller.guardianList.isEmpty) {
              return ErrorIllustration(
                illustrationPath: 'assets/illustration/empty-box.svg',
                title: 'No Guardians Found',
                message:
                    'There are no guardians registered yet. Click the add button to create one.',
                onRetry: _loadData,
              );
            }

            return GuardianGrid(
              data: controller.guardianList,
              onRefresh: () {
                _loadData();
                return controller.getData(ApiEndpoints.getGuardians);
              },
              onDelete: (id) => controller.postDelete(id),
            );
          }),
        ),
      ],
    );
  }
}

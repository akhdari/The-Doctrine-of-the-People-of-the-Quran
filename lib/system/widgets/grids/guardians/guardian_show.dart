import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/controllers/edit_guardian.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/models/post/guardian.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/api_client.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/network/api_endpoints.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/management_buttons_menu.dart';
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

  final Rxn<GuardianInfoDialog> guardian = Rxn<GuardianInfoDialog>();
  final Duration delay = const Duration(seconds: 5);
  late EditGuardian editGuardianController;
  final RxBool hasSelection = false.obs;

  void _loadData() {
    controller.isLoading.value = true;

    Future.wait([
      Future.delayed(duration),
      controller.getData(ApiEndpoints.getSpecialGuardians),
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

    if (!Get.isRegistered<EditGuardian>()) {
      editGuardianController = Get.put(EditGuardian(
        initialLecture: null,
        isEdit: false,
      ));
    } else {
      editGuardianController = Get.find<EditGuardian>();
    }
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
          child: Obx(
            () => TopButtons(
              onAdd: () {
                if (Get.isRegistered<EditGuardian>()) {
                  hasSelection.value = false;
                  guardian.value = null;
                  Get.delete<EditGuardian>();
                }
                Get.put(form.FormController(14));
                Get.put(Generate());
                Get.dialog(GuardianDialog());
              },
              onEdit: () {
                if (guardian.value != null) {
                  Get.put(form.FormController(14));
                  Get.put(Generate());
                  editGuardianController.updateGuardian(guardian.value!);
                  editGuardianController.isEdit = true;
                  Get.dialog(GuardianDialog());
                }
              },
              onDelete: () async {
                if (guardian.value == null) {
                  Get.snackbar('Error', 'No guardian selected for deletion');
                  return;
                }

                await ApiService.delete(ApiEndpoints.getAccountInfoById(
                    guardian.value!.accountInfo.accountId ?? 0));
                setState(() {
                  guardian.value = null;
                  hasSelection.value = false;
                  _loadData();
                });
              },
              hasSelection: hasSelection.value,
            ),
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
                  return controller.getData(ApiEndpoints.getSpecialGuardians);
                },
                onDelete: (id) => controller.postDelete(id, context),
                getObj: (obj) {
                  if (obj != null) {
                    dev.log('Selected lecture: $obj');
                    hasSelection.value = true;
                    guardian.value = obj;
                  } else {
                    dev.log('Deselected lecture');
                    hasSelection.value = false;
                    guardian.value = null;
                  }
                });
          }),
        ),
      ],
    );
  }
}

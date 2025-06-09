import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../drop_down.dart';
import '../../../controllers/submit_form.dart';
import '../../models/post/guardian.dart';
import '../../utils/const/guardian.dart';
import '../../../controllers/generate.dart';

import '../../../controllers/validator.dart';
import '../custom_container.dart';
import '../input_field.dart';
import '../image.dart';
import '../../../controllers/form_controller.dart' as form;
import '../../../system/services/network/api_endpoints.dart';

class GuardianDialogLite extends StatefulWidget {
  const GuardianDialogLite({super.key});

  @override
  State<GuardianDialogLite> createState() => _GuardianDialogLiteState();
}

class _GuardianDialogLiteState extends State<GuardianDialogLite> {
  final GlobalKey<FormState> guardianFormKey = GlobalKey<FormState>();
  late ScrollController scrollController;
  late Generate generate;
  late form.FormController formController;
  final guardianInfo = GuardianInfoDialog();
  @override
  void initState() {
    generate = Get.find<Generate>();
    formController = Get.find<form.FormController>(tag: "guardian");
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    formController.dispose();
    generate.dispose();
    Get.delete<form.FormController>(tag: "guardian");
    Get.delete<Generate>();
    super.dispose();
  }

  RxBool isComplete = true.obs;
  @override
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Dialog(
      shape: BeveledRectangleBorder(),
      backgroundColor: colorScheme.surface,
      child: IntrinsicHeight(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //header
            Stack(children: [
              ColorFiltered(
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.dstIn),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  color: colorScheme.primary,
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ClipRRect(
                  child: CustomAssetImage(assetPath: "assets/back.png"),
                ),
              ),
              Row(
                children: [
                  const Spacer(),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: colorScheme.onSurface,
                    ),
                    onPressed: () => Get.back(),
                  ),
                ],
              )
            ]),

            // Form
            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: guardianFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomContainer(
                      headerText: "guardian info",
                      headerIcon: Icons.person,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: InputField(
                                  inputTitle: "First name ",
                                  child: CustomTextField(
                                    controller: formController.controllers[0],
                                    validator: (value) =>
                                        Validator.notEmptyValidator(
                                            value, "يجب ادخال الاسم"),
                                    focusNode: formController.focusNodes[0],
                                    onSaved: (p0) =>
                                        guardianInfo.guardian.firstName = p0!,
                                    onChanged: (_) =>
                                        guardianInfo.accountInfo.username =
                                            generate.generateUsername(
                                                formController.controllers[0],
                                                formController.controllers[1]),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: InputField(
                                  inputTitle: "Last name ",
                                  child: CustomTextField(
                                    controller: formController.controllers[1],
                                    validator: (value) =>
                                        Validator.notEmptyValidator(
                                            value, "يجب ادخال الاسم"),
                                    focusNode: formController.focusNodes[1],
                                    onSaved: (p0) =>
                                        guardianInfo.guardian.lastName = p0!,
                                    onChanged: (_) =>
                                        guardianInfo.accountInfo.username =
                                            generate.generateUsername(
                                                formController.controllers[0],
                                                formController.controllers[1]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: InputField(
                                  inputTitle: "phone number",
                                  child: CustomTextField(
                                    controller: formController.controllers[2],
                                    validator: (value) =>
                                        Validator.isValidPhoneNumber(value),
                                    focusNode: formController.focusNodes[2],
                                    onSaved: (p0) => guardianInfo
                                        .contactInfo.phoneNumber = p0!,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: InputField(
                                  inputTitle: "email address",
                                  child: CustomTextField(
                                    controller: formController.controllers[3],
                                    validator: (value) =>
                                        Validator.isValidEmail(value),
                                    focusNode: formController.focusNodes[3],
                                    onSaved: (p0) =>
                                        guardianInfo.contactInfo.email = p0!,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: InputField(
                                  inputTitle: "relationship",
                                  child: DropDownWidget(
                                    items: relationship,
                                    initialValue: relationship[0],
                                    onSaved: (p0) => guardianInfo
                                        .guardian.relationship = p0!,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            // Submit button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  isComplete.value = false;
                  guardianInfo.accountInfo.passcode =
                      guardianInfo.accountInfo.username;
                  final success = await submitForm(
                    guardianFormKey,
                    guardianInfo,
                    ApiEndpoints.submitGuardianForm,
                    (GuardianInfoDialog.fromJson),
                  );
                  if (success) {
                    Get.back(); // Close the dialog
                  }
                  isComplete.value = true;
                },
                child: Obx(() => isComplete.value
                    ? Text('Submit')
                    : CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

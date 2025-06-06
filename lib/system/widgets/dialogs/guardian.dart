import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/controllers/edit_guardian.dart';
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

class GuardianDialog extends StatefulWidget {
  const GuardianDialog({super.key});

  @override
  State<GuardianDialog> createState() => _GuardianDialogState();
}

class _GuardianDialogState extends State<GuardianDialog> {
  final GlobalKey<FormState> guardianFormKey = GlobalKey<FormState>();
  late ScrollController scrollController;
  late Generate generate;
  late form.FormController formController;
  var guardianInfo = GuardianInfoDialog();

  EditGuardian? editStudent;

  @override
  void initState() {
    generate = Get.find<Generate>();
    formController = Get.find<form.FormController>();
    formController.controllers[9].text = generate.generatePassword();
    scrollController = ScrollController();

    if (Get.isRegistered<EditGuardian>()) {
      editStudent = Get.find<EditGuardian>();
      guardianInfo = editStudent?.guardian.value ?? GuardianInfoDialog();
    } else {
      editStudent = null;
      guardianInfo.accountInfo.accountType = "guardian";
    }
    super.initState();

    if (editStudent != null) {
      // If we are editing, populate the form with existing data
      formController.controllers[0].text = guardianInfo.guardian.firstName;
      formController.controllers[1].text = guardianInfo.guardian.lastName;
      formController.controllers[2].text = guardianInfo.guardian.relationship;
      formController.controllers[3].text =
          guardianInfo.guardian.dateOfBirth ?? '';
      formController.controllers[4].text = guardianInfo.contactInfo.phoneNumber;
      formController.controllers[5].text = guardianInfo.contactInfo.email;
      formController.controllers[6].text =
          guardianInfo.guardian.homeAddress ?? '';
      formController.controllers[7].text = guardianInfo.guardian.job ?? '';
      formController.controllers[8].text = guardianInfo.accountInfo.username;
      formController.controllers[9].text = guardianInfo.accountInfo.passcode;
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    formController.dispose();
    generate.dispose();
    Get.delete<form.FormController>();
    Get.delete<Generate>();
    super.dispose();
  }

  RxBool isComplete = true.obs;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: Get.width * 0.7,
        maxHeight: Get.height * 0.8,
        minHeight: 400,
        minWidth: 300,
      ),
      child: Dialog(
        shape: BeveledRectangleBorder(),
        backgroundColor: colorScheme.surface,
        child: Scrollbar(
          controller: scrollController,
          child: Column(
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
                    //"assets/back.png"
                    child: CustomImage(imagePath: "assets/back.png"),
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
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: guardianFormKey,
                    child: Column(
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
                                        controller:
                                            formController.controllers[0],
                                        validator: (value) =>
                                            Validator.notEmptyValidator(
                                                value, "يجب ادخال الاسم"),
                                        focusNode: formController.focusNodes[0],
                                        onSaved: (p0) => guardianInfo
                                            .guardian.firstName = p0!,
                                        onChanged: (_) => formController
                                                .controllers[8].text =
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
                                        controller:
                                            formController.controllers[1],
                                        validator: (value) =>
                                            Validator.notEmptyValidator(
                                                value, "يجب ادخال الاسم"),
                                        focusNode: formController.focusNodes[1],
                                        onSaved: (p0) => guardianInfo
                                            .guardian.lastName = p0!,
                                        onChanged: (_) => formController
                                                .controllers[8].text =
                                            generate.generateUsername(
                                                formController.controllers[0],
                                                formController.controllers[1]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: InputField(
                                      inputTitle: "relationship",
                                      child: DropDownWidget(
                                        items: relationship,
                                        initialValue: editStudent != null
                                            ? guardianInfo.guardian.relationship
                                            : relationship[0],
                                        onSaved: (p0) => guardianInfo
                                            .guardian.relationship = p0!,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: InputField(
                                      inputTitle: "Date of Birth",
                                      child: CustomTextField(
                                        controller:
                                            formController.controllers[3],
                                        onSaved: (p0) => guardianInfo
                                            .guardian.dateOfBirth = p0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              //contact
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: InputField(
                                      inputTitle: "phone number",
                                      child: CustomTextField(
                                        controller:
                                            formController.controllers[4],
                                        validator: (value) =>
                                            Validator.isValidPhoneNumber(value),
                                        focusNode: formController.focusNodes[4],
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
                                        controller:
                                            formController.controllers[5],
                                        validator: (value) =>
                                            Validator.isValidEmail(value),
                                        focusNode: formController.focusNodes[5],
                                        onSaved: (p0) => guardianInfo
                                            .contactInfo.email = p0!,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: InputField(
                                      inputTitle: "address",
                                      child: CustomTextField(
                                        controller:
                                            formController.controllers[6],
                                        onSaved: (p0) => guardianInfo
                                            .guardian.homeAddress = p0,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: InputField(
                                      inputTitle: "job",
                                      child: CustomTextField(
                                        controller:
                                            formController.controllers[7],
                                        onSaved: (p0) =>
                                            guardianInfo.guardian.job = p0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomContainer(
                          headerIcon: Icons.account_box,
                          headerText: "account info",
                          child: Row(
                            children: [
                              Expanded(
                                child: InputField(
                                  inputTitle: "username",
                                  child: CustomTextField(
                                    controller: formController.controllers[8],
                                    onSaved: (p0) =>
                                        guardianInfo.accountInfo.username = p0!,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: InputField(
                                  inputTitle: "password",
                                  child: CustomTextField(
                                    controller: formController.controllers[9],
                                    onSaved: (p0) =>
                                        guardianInfo.accountInfo.passcode = p0!,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),

                        //TODO
                        CustomContainer(
                          headerIcon: Icons.image,
                          headerText: "add account image",
                          child: const Text("add image"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Submit button
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    debugPrint(
                        'Form valid: ${guardianFormKey.currentState?.validate()}');
                    debugPrint(
                        'Fields: ${formController.controllers.map((c) => c.text)}');

                    isComplete.value = false;

                    if (guardianFormKey.currentState?.validate() ?? false) {
                      // Save the form data
                      guardianFormKey.currentState?.save();
                      debugPrint('Form saved: ${guardianInfo.toMap()}');
                      try {
                        final success = editStudent == null
                            ? await submitForm(
                                guardianFormKey,
                                guardianInfo,
                                ApiEndpoints.submitGuardianForm,
                                (GuardianInfoDialog.fromMap),
                              )
                            : await submitEditDataForm(
                                guardianFormKey,
                                guardianInfo,
                                ApiEndpoints.getSpecialGuardiansById(
                                    guardianInfo.accountInfo.accountId ?? 0),
                                (GuardianInfoDialog.fromMap),
                              );
                        if (success) {
                          Get.back(); // Close the dialog
                          Get.snackbar('Success',
                              'Guardian data submitted successfully');
                        } else {
                          // Show error message if submission failed
                          Get.snackbar(
                              'Error', 'Failed to submit guardian data');
                        }
                      } catch (e) {
                        // Handle any errors during submission
                        Get.snackbar('Error',
                            'An error occurred while submitting the form');
                        debugPrint('Error submitting form: $e');
                      } finally {
                        // Ensure to re-enable the submit button
                        isComplete.value = true;
                      }
                    } else {
                      // If form is invalid, show an error message
                      Get.snackbar(
                          'Error', 'Please fill out all required fields');
                      isComplete.value = true;
                    }
                  },
                  child: Obx(() => isComplete.value
                      ? const Text('Submit')
                      : const CircularProgressIndicator()),
                ),
              ),
              //
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/controllers/generic_edit_controller.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/dialogs/dialog.dart';
import '../drop_down.dart';
import '../../../controllers/submit_form.dart';
import '../../models/post/guardian.dart';
import '../../utils/const/guardian.dart';
import '../../../controllers/generate.dart';
import '../../../controllers/validator.dart';
import '../custom_container.dart';
import '../input_field.dart';
import '../../../controllers/form_controller.dart' as form;
import '../../../system/services/network/api_endpoints.dart';

class GuardianDialog extends GlobalDialog {
  const GuardianDialog(
      {super.key, super.dialogHeader = "إضافة ولي", super.numberInputs = 9});

  @override
  State<GlobalDialog> createState() => _GuardianDialogState();
}

class _GuardianDialogState<
        GEC extends GenericEditController<GuardianInfoDialog>>
    extends DialogState<GEC> {
  final GlobalKey<FormState> guardianFormKey = GlobalKey<FormState>();
  late Generate generate;
  var guardianInfo = GuardianInfoDialog();

  @override
  void initState() {
    super.initState();
    generate = Get.find<Generate>();
    formController.controllers[9].text = generate.generatePassword();

    if (editController != null) {
      guardianInfo = editController?.model.value ?? GuardianInfoDialog();
    } else {
      guardianInfo.accountInfo.accountType = "guardian";
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

  @override
  Column formChild() {
    return Column(
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
                        validator: (value) => Validator.notEmptyValidator(
                            value, "يجب ادخال الاسم"),
                        focusNode: formController.focusNodes[0],
                        onSaved: (p0) => guardianInfo.guardian.firstName = p0!,
                        onChanged: (_) => formController.controllers[8].text =
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
                        validator: (value) => Validator.notEmptyValidator(
                            value, "يجب ادخال الاسم"),
                        focusNode: formController.focusNodes[1],
                        onSaved: (p0) => guardianInfo.guardian.lastName = p0!,
                        onChanged: (_) => formController.controllers[8].text =
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
                        initialValue: editController != null
                            ? guardianInfo.guardian.relationship
                            : relationship[0],
                        onSaved: (p0) =>
                            guardianInfo.guardian.relationship = p0!,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: InputField(
                      inputTitle: "Date of Birth",
                      child: CustomTextField(
                        controller: formController.controllers[3],
                        onSaved: (p0) => guardianInfo.guardian.dateOfBirth = p0,
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
                        controller: formController.controllers[4],
                        validator: (value) =>
                            Validator.isValidPhoneNumber(value),
                        focusNode: formController.focusNodes[4],
                        onSaved: (p0) =>
                            guardianInfo.contactInfo.phoneNumber = p0!,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: InputField(
                      inputTitle: "email address",
                      child: CustomTextField(
                        controller: formController.controllers[5],
                        validator: (value) => Validator.isValidEmail(value),
                        focusNode: formController.focusNodes[5],
                        onSaved: (p0) => guardianInfo.contactInfo.email = p0!,
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
                        controller: formController.controllers[6],
                        onSaved: (p0) => guardianInfo.guardian.homeAddress = p0,
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
                        controller: formController.controllers[7],
                        onSaved: (p0) => guardianInfo.guardian.job = p0,
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
                    onSaved: (p0) => guardianInfo.accountInfo.username = p0!,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: InputField(
                  inputTitle: "password",
                  child: CustomTextField(
                    controller: formController.controllers[9],
                    onSaved: (p0) => guardianInfo.accountInfo.passcode = p0!,
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
    );
  }

  @override
  Future<void> loadData() {
    // TODO: implement loadData
    throw UnimplementedError();
  }

  @override
  void setDefaultFieldsValue() {
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

  @override
  Future<bool> submit() async {
    return editController == null
        ? await submitForm(
            guardianFormKey,
            guardianInfo,
            ApiEndpoints.submitGuardianForm,
            (GuardianInfoDialog.fromJson),
          )
        : await submitEditDataForm(
            guardianFormKey,
            guardianInfo,
            ApiEndpoints.getSpecialGuardiansById(
                guardianInfo.accountInfo.accountId ?? 0),
            (GuardianInfoDialog.fromJson),
          );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/drop_down.dart';
import '../../logic/submit_form.dart';
import '../const/guardian_class.dart';
import '../const/guardian_const.dart';
import '../../logic/generate.dart';
import '../connect/connect.dart';
import '../../logic/validators.dart';
import '../widgets/containers.dart';
import '../widgets/input_field.dart';

const String url = 'http://192.168.100.20/phpscript/get_guardian.php';

class GuardianDialog extends StatefulWidget {
  const GuardianDialog({super.key});

  @override
  State<GuardianDialog> createState() => _GuardianDialogState();
}

class _GuardianDialogState extends State<GuardianDialog> {
  final GlobalKey<FormState> guardianFormKey = GlobalKey<FormState>();
  late ScrollController scrollController;
  late Generate generate;
  late Validator validator;
  final Connect connect = Connect();
  final guardianInfo = Guardian();
  @override
  void initState() {
    generate = Get.find<Generate>();
    validator = Get.find<Validator>(tag: "guardianPage");
    validator.controllers[9].text = generate.generatePassword();
    scrollController = ScrollController();
    super.initState();
  }

  RxBool isComplete = true.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: Get.width * 0.7,
          maxHeight: Get.height * 0.8,
          minHeight: 400,
          minWidth: 300,
        ),
        child: Dialog(
          shape: BeveledRectangleBorder(),
          backgroundColor: Colors.white,
          child: Scrollbar(
            controller: scrollController,
            child: Column(
              children: [
                //header
                Stack(children: [
                  ColorFiltered(
                    colorFilter:
                        ColorFilter.mode(Colors.white, BlendMode.dstIn),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      color: const Color(0xFF0E9D6D),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ClipRRect(
                      child: Image.asset(
                        "assets/back.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
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
                            title: "guardian info",
                            icon: Icons.person,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: InputField(
                                        inputTitle: "First name ",
                                        child: CustomTextField(
                                          controller: validator.controllers[0],
                                          validator:
                                              validator.notEmptyValidator(
                                                  "يجب ادخال الاسم"),
                                          focusNode: validator.focusNodes[0],
                                          onSaved: (p0) =>
                                              guardianInfo.firstName = p0!,
                                          onChanged: (_) =>
                                              validator.controllers[8].text =
                                                  generate.generateUsername(
                                                      validator.controllers[0],
                                                      validator.controllers[1]),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: InputField(
                                        inputTitle: "Last name ",
                                        child: CustomTextField(
                                          controller: validator.controllers[1],
                                          validator:
                                              validator.notEmptyValidator(
                                                  "يجب ادخال الاسم"),
                                          focusNode: validator.focusNodes[1],
                                          onSaved: (p0) =>
                                              guardianInfo.lastName = p0!,
                                          onChanged: (_) =>
                                              validator.controllers[8].text =
                                                  generate.generateUsername(
                                                      validator.controllers[0],
                                                      validator.controllers[1]),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                //birthday, relationship

                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: InputField(
                                        inputTitle: "relationship",
                                        child: DropDownWidget(
                                          items: relationship,
                                          initialValue: relationship[0],
                                          onSaved: (p0) =>
                                              guardianInfo.relationship = p0!,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: InputField(
                                        inputTitle: "Date of Birth",
                                        child: CustomTextField(
                                          controller: validator.controllers[3],
                                          onSaved: (p0) =>
                                              guardianInfo.dateOfBirth = p0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                //contact
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: InputField(
                                        inputTitle: "phone number",
                                        child: CustomTextField(
                                          controller: validator.controllers[4],
                                          validator: (value) => validator
                                              .isValidPhoneNumber(value),
                                          focusNode: validator.focusNodes[4],
                                          onSaved: (p0) =>
                                              guardianInfo.phoneNumber = p0!,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: InputField(
                                        inputTitle: "email address",
                                        child: CustomTextField(
                                          controller: validator.controllers[5],
                                          validator: (value) =>
                                              validator.isValidEmail(value),
                                          focusNode: validator.focusNodes[5],
                                          onSaved: (p0) =>
                                              guardianInfo.email = p0!,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                //job, address
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: InputField(
                                        inputTitle: "address",
                                        child: CustomTextField(
                                          controller: validator.controllers[6],
                                          onSaved: (p0) =>
                                              guardianInfo.address = p0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: InputField(
                                        inputTitle: "job",
                                        child: CustomTextField(
                                          controller: validator.controllers[7],
                                          onSaved: (p0) =>
                                              guardianInfo.job = p0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomContainer(
                            icon: Icons.account_box,
                            title: "account info",
                            child: Row(
                              children: [
                                Expanded(
                                  child: InputField(
                                    inputTitle: "username",
                                    child: CustomTextField(
                                      controller: validator.controllers[8],
                                      onSaved: (p0) =>
                                          guardianInfo.username = p0!,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: InputField(
                                    inputTitle: "password",
                                    child: CustomTextField(
                                      controller: validator.controllers[9],
                                      onSaved: (p0) =>
                                          guardianInfo.passcode = p0!,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10), //TODO const???

                          // Image
                          CustomContainer(
                            icon: Icons.image,
                            title: "add account image",
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
                        isComplete.value = false;

                        await submitForm(guardianFormKey, connect, guardianInfo,
                            url, isComplete);

                        isComplete.value = true;
                      },
                      child: Obx(() => isComplete.value
                          ? Text('Submit')
                          : CircularProgressIndicator()),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiple_search_selection/multiple_search_selection.dart';
import '../timer.dart';
import '../custom_container.dart';
import '../input_field.dart';
import '../../../controllers/validator.dart';
import '../../models/post/student.dart';
import '../../services/connect.dart';
import '../multiselect.dart';
import '../../services/get_sessions.dart';
import '../../services/get_guardians.dart';
import '../../utils/const/student.dart';
import '../../../controllers/generate.dart';
import '../drop_down.dart';
import '../../../controllers/submit_form.dart';
import '../picker.dart';

const String url = 'http://192.168.100.20/phpscript/get_student.php';

class StudentDialog extends StatefulWidget {
  const StudentDialog({super.key});

  @override
  State<StudentDialog> createState() => _StudentDialogState();
}

class _StudentDialogState extends State<StudentDialog> {
  Future<void> loadData() async {
    try {
      final fetchedSessionNames = await getSessions();
      final fetchedGuardianAccounts = await getGuardians();

      dev.log('sessionNames: ${fetchedSessionNames.toString()}');
      dev.log('guardianAccounts: ${fetchedGuardianAccounts.toString()}');

      setState(() {
        sessionNames = fetchedSessionNames;
        guardianAccounts = fetchedGuardianAccounts;
      });
    } catch (e) {
      dev.log("Error loading data: $e");
    }
  }

  // Controllers and keys
  final GlobalKey<FormState> studentFormKey = GlobalKey<FormState>();

  late Generate generate;
  late Validator validator;
  final Connect connect = Connect();
  final StudentInfoDialog studentInfo = StudentInfoDialog();

  // State variables
  bool isClicked = false;
  RxBool isExempt = false.obs;
  Rx<String?> enrollmentDate = Rxn<String>();
  Rx<String?> exitDate = Rxn<String>();

  late List<Map<String, dynamic>> sessionNames = [];
  late List<Map<String, dynamic>> guardianAccounts = [];

  late MultipleSearchController multiSearchController1;
  late MultipleSearchController multiSearchController2;
  //scroll conroller
  late ScrollController scrollController;
  //picker
  late Picker imagePicker;
  @override
  void initState() {
    super.initState();
    generate = Get.find<Generate>();
    validator = Get.find<Validator>(tag: "studentPage");

    validator.controllers[9].text = generate.generatePassword();

    /*multiSearchController1 = MultipleSearchController(
      minCharsToShowItems: 1,
      allowDuplicateSelection: false,
    );
    multiSearchController2 = MultipleSearchController(
      minCharsToShowItems: 1,
      allowDuplicateSelection: false,
    );*/
    scrollController = ScrollController();
    loadData();
  }

  RxBool isComplete = true.obs;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
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
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.dstIn),
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
                    key: studentFormKey,
                    child: Column(
                      children: [
                        // Session
                        CustomContainer(
                          icon: Icons.book,
                          title: "session",
                          child: DefaultConstructorExample(
                            //multipleSearchController: multiSearchController1,
                            getPickedItems: (p0) {
                              studentInfo.sessions = p0;
                            },
                            searchkey: "lecture_name_ar",
                            hintText: "search for sessions",
                            preparedData: sessionNames,
                            maxSelectedItems: null,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Personal Info
                        CustomContainer(
                          icon: Icons.person,
                          title: "Students' Personal Info",
                          child: Column(
                            children: [
                              // Name fields
                              Row(
                                children: [
                                  Expanded(
                                    child: InputField(
                                      inputTitle: "First name in Arabic",
                                      child: CustomTextField(
                                        controller: validator.controllers[1],
                                        validator: validator.notEmptyValidator(
                                            "يجب ادخال الاسم"),
                                        focusNode: validator.focusNodes[1],
                                        onSaved: (p0) =>
                                            studentInfo.firstNameAR = p0!,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: InputField(
                                      inputTitle: "Last name in Arabic",
                                      child: CustomTextField(
                                        controller: validator.controllers[2],
                                        validator: validator.notEmptyValidator(
                                            "يجب ادخال الاسم"),
                                        focusNode: validator.focusNodes[2],
                                        onSaved: (p0) =>
                                            studentInfo.lastNameAR = p0!,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),

                              // Latin name fields
                              Row(
                                children: [
                                  Expanded(
                                    child: InputField(
                                      inputTitle: "First name in Latin",
                                      child: CustomTextField(
                                        controller: validator.controllers[3],
                                        textDirection: TextDirection.ltr,
                                        onChanged: (_) =>
                                            validator.controllers[8].text =
                                                generate.generateUsername(
                                                    validator.controllers[3],
                                                    validator.controllers[4]),
                                        onSaved: (p0) =>
                                            studentInfo.firstNameEN = p0,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: InputField(
                                      inputTitle: "Last name in Latin",
                                      child: CustomTextField(
                                        controller: validator.controllers[4],
                                        textDirection: TextDirection.ltr,
                                        onChanged: (_) =>
                                            validator.controllers[8].text =
                                                generate.generateUsername(
                                                    validator.controllers[3],
                                                    validator.controllers[4]),
                                        onSaved: (p0) =>
                                            studentInfo.lastNameEN = p0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),

                              // Sex and DOB
                              Row(
                                children: [
                                  Expanded(
                                    child: InputField(
                                      inputTitle: "Sex",
                                      child: DropDownWidget(
                                        items: sex,
                                        initialValue: sex[0],
                                        onSaved: (p0) => studentInfo.sex = p0!,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: InputField(
                                      inputTitle: "Date of Birth",
                                      child: CustomTextField(
                                        controller: validator.controllers[5],
                                        onSaved: (p0) =>
                                            studentInfo.dateOfBirth = p0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),

                              // Nationality and Address
                              Row(
                                children: [
                                  Expanded(
                                    child: InputField(
                                      inputTitle: "Nationality",
                                      child: CustomTextField(
                                        controller: validator.controllers[6],
                                        onSaved: (p0) =>
                                            studentInfo.nationality = p0!,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: InputField(
                                      inputTitle: "Address",
                                      child: CustomTextField(
                                        controller: validator.controllers[7],
                                        onSaved: (p0) =>
                                            studentInfo.address = p0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Account Info
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
                                    onSaved: (p0) => studentInfo.username = p0!,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: InputField(
                                  inputTitle: "password",
                                  child: CustomTextField(
                                    controller: validator.controllers[9],
                                    onSaved: (p0) => studentInfo.password = p0!,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Health Info
                        CustomContainer(
                          icon: Icons.health_and_safety,
                          title: "health info",
                          child: Row(
                            children: [
                              Expanded(
                                child: InputField(
                                  inputTitle: "blood type",
                                  child: DropDownWidget(
                                    items: bloodType,
                                    initialValue: null,
                                    onSaved: (p0) => studentInfo.bloodType = p0,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: InputField(
                                  inputTitle: "has disease",
                                  child: DropDownWidget(
                                    items: yesNo,
                                    initialValue: null,
                                    onSaved: (p0) =>
                                        studentInfo.hasDisease = p0,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: InputField(
                                  inputTitle: "disease causes",
                                  child: CustomTextField(
                                    controller: validator.controllers[10],
                                    onSaved: (p0) =>
                                        studentInfo.diseaseCauses = p0,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: InputField(
                                  inputTitle: "allergies",
                                  child: CustomTextField(
                                    controller: validator.controllers[10],
                                    onSaved: (p0) => studentInfo.allergies = p0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Contact Info
                        CustomContainer(
                          icon: Icons.phone,
                          title: "contact info",
                          child: Row(
                            children: [
                              Expanded(
                                child: InputField(
                                  inputTitle: "phone number",
                                  child: CustomTextField(
                                    controller: validator.controllers[11],
                                    validator: (value) =>
                                        validator.isValidPhoneNumber(value),
                                    focusNode: validator.focusNodes[11],
                                    onSaved: (p0) =>
                                        studentInfo.phoneNumber = p0!,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: InputField(
                                  inputTitle: "email address",
                                  child: CustomTextField(
                                    controller: validator.controllers[12],
                                    validator: (value) =>
                                        validator.isValidEmail(value),
                                    focusNode: validator.focusNodes[12],
                                    onSaved: (p0) =>
                                        studentInfo.emailAddress = p0!,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Parent Status
                        Row(
                          children: [
                            Expanded(
                              child: CustomContainer(
                                icon: Icons.person,
                                title: "father state",
                                child: DropDownWidget(
                                  items: state,
                                  initialValue: state[0],
                                  onSaved: (p0) =>
                                      studentInfo.fatherStatus = p0,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: CustomContainer(
                                icon: Icons.person,
                                title: "mother state",
                                child: DropDownWidget(
                                  items: state,
                                  initialValue: state[0],
                                  onSaved: (p0) =>
                                      studentInfo.motherStatus = p0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Guardian Info
                        CustomContainer(
                          icon: Icons.family_restroom,
                          title: "info about guardian",
                          child: InputField(
                            inputTitle: "guardian's account",
                            child: DefaultConstructorExample(
                              //multipleSearchController: multiSearchController2,
                              getPickedItems: (c) {
                                studentInfo.username2 = c[0];
                              },
                              preparedData: guardianAccounts,
                              searchkey: "username",
                              hintText: "search for guardian account",
                              maxSelectedItems: 1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Subscription Info
                        CustomContainer(
                          title: "subscription information",
                          icon: Icons.subscriptions,
                          child: Column(
                            children: [
                              Row(children: [
                                Expanded(
                                  child: InputField(
                                    inputTitle: "enrollment date",
                                    child: Obx(
                                      () => OutlinedButton(
                                        onPressed: () async {
                                          await dateSelector(Get.context!)
                                              .then((value) {
                                            if (value != null) {
                                              enrollmentDate.value = value;
                                              studentInfo.enrollmentDate =
                                                  value;
                                            }
                                          });
                                        },
                                        child: Text(enrollmentDate.value ??
                                            "select date"),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InputField(
                                    inputTitle: "is exempt from payment",
                                    child: DropDownWidget<bool>(
                                      items: trueFalse,
                                      initialValue: trueFalse[1],
                                      onChanged: (p0) {
                                        isExempt.value = p0!;
                                        dev.log("isExempt: $isExempt");
                                      },
                                      onSaved: (p0) =>
                                          studentInfo.isExempt = p0,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: InputField(
                                    inputTitle: "exemption percentage",
                                    child: Obx(
                                      () => AbsorbPointer(
                                        absorbing: !isExempt.value,
                                        child: Opacity(
                                          opacity: isExempt.value ? 1.0 : 0.5,
                                          child: DropDownWidget<double>(
                                            items: exemptionPercentage,
                                            initialValue: isExempt.value
                                                ? studentInfo.exemptionPercent
                                                : null,
                                            onChanged: (p0) {
                                              studentInfo.exemptionPercent =
                                                  isExempt.value ? p0 : null;
                                            },
                                            onSaved: (p0) => studentInfo
                                                .exemptionPercent = p0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                              const SizedBox(height: 8),
                              Row(children: [
                                Expanded(
                                  child: InputField(
                                    inputTitle: "exit date",
                                    child: Obx(
                                      () => OutlinedButton(
                                        onPressed: () async {
                                          await dateSelector(Get.context!)
                                              .then((value) {
                                            if (value != null) {
                                              exitDate.value = value;
                                              studentInfo.exitDate = value;
                                            }
                                          });
                                        },
                                        child: Text(
                                            exitDate.value ?? "select date"),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InputField(
                                    inputTitle: "exit reason",
                                    child: CustomTextField(
                                      controller: validator.controllers[14],
                                      onSaved: (p0) =>
                                          studentInfo.exitReason = p0,
                                      maxLines: 3,
                                    ),
                                  ),
                                ),
                              ])
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Formal Education
                        CustomContainer(
                          title: "formal education",
                          icon: Icons.school,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: InputField(
                                      inputTitle: "school type",
                                      child: DropDownWidget(
                                        items: schoolType,
                                        initialValue: null,
                                        onSaved: (p0) =>
                                            studentInfo.schoolType = p0,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: InputField(
                                      inputTitle: "school name",
                                      child: CustomTextField(
                                        controller: validator.controllers[15],
                                        onSaved: (p0) =>
                                            studentInfo.schoolName = p0,
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
                                      inputTitle: "academic level",
                                      child: DropDownWidget(
                                        items: academicLevel,
                                        onSaved: (p0) =>
                                            studentInfo.academicLevel = p0,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: InputField(
                                      inputTitle: "grade",
                                      child: DropDownWidget(
                                        items: grades,
                                        onSaved: (p0) => studentInfo.grade = p0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Image
                        CustomContainer(
                          icon: Icons.image,
                          title: "add account image",
                          child: OutlinedButton(
                            onPressed: () {
                              imagePicker;
                            },
                            child: Text("pick image"),
                          ),
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

                      await submitForm(studentFormKey, connect, studentInfo,
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
    );
  }
}

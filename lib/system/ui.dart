import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiple_search_selection/multiple_search_selection.dart';
import 'dart:math';
import './widgets/timer.dart';
import './widgets/containers.dart';
import './widgets/input_field.dart';
import './widgets/end_drawer.dart';
import './widgets/theme.dart';
import '../logic/validators.dart';
import 'const/info.dart';
import 'connect/connect.dart';
import 'widgets/multiselect.dart';
import 'connect/get_sessions.dart';
import 'connect/get_guardians.dart';

// Constants
const url = 'http://192.168.100.20/phpscript/get_student.php';
const List<String> sex = ["male", "female"];
const List<String> bloodType = [
  "A+",
  "A-",
  "B+",
  "B-",
  "AB+",
  "AB-",
  "O+",
  "O-"
];
const List<String> yesNo = ["yes", "no"];
const List<bool> trueFalse = [true, false];
List<String?> schoolType = ["public", "private", "international"];
const List<String> academicLevel = [
  "Kindergarten",
  "Primary School",
  "Elementary School",
  "Middle School",
  "High School",
  "Undergraduate",
  "Postgraduate",
  "Doctorate"
];
const List<String> grades = [
  "Grade 1",
  "Grade 2",
  "Grade 3",
  "Grade 4",
  "Grade 5",
  "Grade 6",
  "Grade 7",
  "Grade 8",
  "Grade 9",
  "Grade 10",
  "Grade 11",
  "Grade 12",
  "Undergraduate Year 1",
  "Undergraduate Year 2",
  "Undergraduate Year 3",
  "Undergraduate Year 4",
  "Master's Year 1",
  "Master's Year 2",
  "Doctorate Year 1",
  "Doctorate Year 2",
  "Doctorate Year 3"
];
List<double> exemptionPercentage = [25, 50, 75, 100];
const List<String> state = ["alive", "dead"];
const List<String> test = ["single", "married", "widowed"];

class Generate extends GetxController {
  String generateUsername(
      TextEditingController lastName, TextEditingController firstName) {
    if (firstName.text.isNotEmpty && lastName.text.isNotEmpty) {
      Random random = Random();
      String ln = lastName.text.trim();
      String fn = firstName.text.trim();
      String lnPart = ln.length >= 3 ? ln.substring(0, 3) : ln;
      String fnPart = fn.length >= 3 ? fn.substring(0, 3) : fn;
      String username = lnPart + fnPart + random.nextInt(10).toString();
      return username;
    }
    return "please enter your name";
  }

  String generatePassword() {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#%&*';
    const length = 10;
    final Random random = Random.secure();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)])
        .join();
  }
}

class StudentDialog extends StatefulWidget {
  const StudentDialog({super.key});

  @override
  State<StudentDialog> createState() => _StudentDialogState();
}

class _StudentDialogState extends State<StudentDialog> {
  Future<void> _loadData() async {
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

  Future<void> submitForm() async {
    if (studentFormKey.currentState!.validate()) {
      studentFormKey.currentState!.save();
      if (studentInfo.isComplete) {
        try {
          final response = await connect.post(url, studentInfo);
          dev.log(response.toString());
          Get.back(); // Close the dialog
          Get.snackbar('Success', 'Form submitted successfully');
        } catch (e) {
          dev.log("Error submitting form: $e");
          Get.snackbar('Error', 'Failed to submit form');
        }
      } else {
        Get.snackbar('Error', 'Please complete all required fields');
      }
    }
  }

  // Controllers and keys
  final GlobalKey<FormState> studentFormKey = GlobalKey<FormState>();

  late Generate generate;
  late Validator validator;
  late ThemeController themeController;
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

  @override
  void initState() {
    super.initState();
    generate = Get.put(Generate());
    validator = Get.find<Validator>(tag: "uiPage");
    themeController = Get.find<ThemeController>();

    validator.controllers[9].text = generate.generatePassword();

    multiSearchController1 = MultipleSearchController(
      minCharsToShowItems: 1,
      allowDuplicateSelection: false,
    );
    multiSearchController2 = MultipleSearchController(
      minCharsToShowItems: 1,
      allowDuplicateSelection: false,
    );
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: Get.width * 0.7,
        maxHeight: Get.height * 0.8,
      ),
      child: Dialog(
        shape: BeveledRectangleBorder(),
        backgroundColor: Colors.white,
        child: Scrollbar(
          controller: scrollController,
          child: Column(
            children: [
              // Header
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
                            multipleSearchController: multiSearchController1,
                            pickedItems: studentInfo.sessions,
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
                              multipleSearchController: multiSearchController2,
                              pickedItems:
                                  studentInfo.username2, //studentInfo.username2
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
                child: OutlinedButton(
                  onPressed: () {
                    validator.moveToTheFirstEmptyFeild(studentFormKey);
                    submitForm();
                  },
                  child: const Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SystemUI extends StatefulWidget {
  final dialogContent = const StudentDialog();
  const SystemUI({super.key});

  @override
  State<SystemUI> createState() => _SystemUIState();
}

class _SystemUIState extends State<SystemUI> {
  final GlobalKey<ScaffoldState> studentScaffoldKey =
      GlobalKey<ScaffoldState>();

  bool isClicked = false;
  late ThemeController themeController;

  @override
  void initState() {
    super.initState();

    themeController = Get.find<ThemeController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: studentScaffoldKey,
      drawerEnableOpenDragGesture: true,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => studentScaffoldKey.currentState?.openEndDrawer(),
          ),
        ],
      ),
      endDrawer: customEndDrawer(),
      body: Column(
        children: [
          IconButton(
            onPressed: () {
              isClicked = !isClicked;
              themeController.switchTheme();
              dev.log("theme changed");
            },
            icon: const Icon(Icons.nightlight_round),
          ),
          Center(
            child: OutlinedButton(
              onPressed: () => Get.dialog(widget.dialogContent),
              child: const Text("Open Student Form"),
            ),
          ),
        ],
      ),
    );
  }
}

class DropDownWidget<T> extends StatefulWidget {
  final List<T> items;
  final T? initialValue;
  final void Function(T?)? onChanged;
  final void Function(T?)? onSaved;

  const DropDownWidget({
    super.key,
    required this.items,
    this.initialValue,
    this.onChanged,
    this.onSaved,
  });

  @override
  State<DropDownWidget<T>> createState() => _DropDownWidgetState<T>();
}

class _DropDownWidgetState<T> extends State<DropDownWidget<T>> {
  T? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      decoration: const InputDecoration(
        filled: false,
        border: OutlineInputBorder(),
      ),
      value: _selectedValue,
      items: widget.items.map((T value) {
        return DropdownMenuItem<T>(
          value: value,
          child: Text(value.toString()),
        );
      }).toList(),
      onChanged: (T? newValue) {
        setState(() => _selectedValue = newValue);
        widget.onChanged?.call(newValue);
      },
      onSaved: widget.onSaved,
    );
  }
}

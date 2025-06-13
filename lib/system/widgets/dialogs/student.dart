import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/controllers/generic_edit_controller.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/controllers/submit_form.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/guardian.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/lecture.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/services/network/api_endpoints.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/dialogs/dialog.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/dialogs/guardian_from_student.dart';
import '../timer.dart';
import '../custom_container.dart';
import '../input_field.dart';
import '../../../controllers/validator.dart';
import '../../models/post/student.dart';
import '../multiselect.dart';
import '../../utils/const/student.dart';
import '../../../controllers/generate.dart';
import '../drop_down.dart';
import '../../../controllers/form_controller.dart' as form;
import './image_picker_widget.dart';

class StudentDialog extends GlobalDialog {
  const StudentDialog({
    super.key,
    super.dialogHeader = "إضافة طالب",
    super.numberInputs = 15,
  });

  @override
  State<GlobalDialog> createState() =>
      _StudentDialogState<GenericEditController<StudentInfoDialog>>();
}

class _StudentDialogState<GEC extends GenericEditController<StudentInfoDialog>>
    extends DialogState<GEC> {
  final GlobalKey<FormState> studentFormKey = GlobalKey<FormState>();
  late Generate generate;
  StudentInfoDialog studentInfo = StudentInfoDialog();
  bool isClicked = false;
  RxBool isExempt = false.obs;
  Rx<String?> enrollmentDate = Rxn<String>();
  Rx<String?> exitDate = Rxn<String>();
  MultiSelectResult<Lecture>? sessionResult;
  MultiSelectResult? guardianResult;
  //late Picker imagePicker;

  @override
  Future<void> loadData() async {
    try {
      final fetchedSessionNames =
          await getItems<Lecture>(ApiEndpoints.getLectures, Lecture.fromJson);
      final fetchedGuardianAccounts = await getItems<Guardian>(
          ApiEndpoints.getGuardianAccounts, Guardian.fromJson);

      dev.log('sessionNames: ${fetchedSessionNames.toString()}');
      dev.log('guardianAccounts: ${fetchedGuardianAccounts.toString()}');

      setState(() {
        sessionResult = fetchedSessionNames;
        guardianResult = fetchedGuardianAccounts;
      });
    } catch (e) {
      dev.log("Error loading data: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    generate = Get.isRegistered<Generate>()
        ? Get.find<Generate>()
        : Get.put(Generate());
    formController.controllers[7].text = generate.generatePassword();

    if (editController?.model.value != null) {
      studentInfo = editController?.model.value ?? StudentInfoDialog();
    } else {
      studentInfo.accountInfo.accountType = "student";
    }
  }

  @override
  void dispose() {
    generate.dispose();
    if (Get.isRegistered<Generate>()) {
      Get.delete<Generate>();
    }
    super.dispose();
  }

  @override
  Column formChild() {
    return Column(
      children: [
        SessionSection(
          sessionResult: sessionResult,
          editController: editController,
          studentInfo: studentInfo,
        ),
        const SizedBox(height: 10),
        PersonalInfoSection(
          formController: formController,
          editController: editController,
          studentInfo: studentInfo,
          generate: generate,
        ),
        const SizedBox(height: 10),
        AccountInfoSection(
          formController: formController,
          studentInfo: studentInfo,
        ),
        const SizedBox(height: 10),
        HealthInfoSection(
          formController: formController,
          editController: editController,
          studentInfo: studentInfo,
        ),
        const SizedBox(height: 10),
        ContactInfoSection(
          formController: formController,
          studentInfo: studentInfo,
        ),
        const SizedBox(height: 10),
        ParentStatusSection(
          editController: editController,
          studentInfo: studentInfo,
        ),
        const SizedBox(height: 10),
        GuardianInfoSection(
          guardianResult: guardianResult,
          studentInfo: studentInfo,
        ),
        const SizedBox(height: 10),
        SubscriptionInfoSection(
          formController: formController,
          editController: editController,
          studentInfo: studentInfo,
          enrollmentDate: enrollmentDate,
          exitDate: exitDate,
          isExempt: isExempt,
        ),
        const SizedBox(height: 10),
        FormalEducationSection(
          formController: formController,
          editController: editController,
          studentInfo: studentInfo,
        ),
        const SizedBox(height: 10),
        ImagePickerWidget.imagePreviewWidget(
          context,
          editController?.model.value?.personalInfo.profileImage,
        ),
      ],
    );
  }

  @override
  void setDefaultFieldsValue() {
    final s = editController?.model.value;
    formController.controllers[0].text = s?.personalInfo.firstNameAr ?? '';
    formController.controllers[1].text = s?.personalInfo.lastNameAr ?? '';
    formController.controllers[2].text = s?.personalInfo.firstNameEn ?? '';
    formController.controllers[3].text = s?.personalInfo.lastNameEn ?? '';
    formController.controllers[4].text = s?.personalInfo.dateOfBirth ?? '';
    formController.controllers[5].text = s?.personalInfo.homeAddress ?? '';
    formController.controllers[6].text = s?.accountInfo.username ?? '';
    formController.controllers[7].text = s?.accountInfo.passcode ?? '';
    formController.controllers[8].text = s?.medicalInfo.diseasesCauses ?? '';
    formController.controllers[9].text = s?.medicalInfo.allergies ?? '';
    formController.controllers[10].text = s?.contactInfo.phoneNumber ?? '';
    formController.controllers[11].text = s?.contactInfo.email ?? '';
    formController.controllers[12].text = s?.subscriptionInfo.exitReason ?? '';
    formController.controllers[13].text =
        s?.formalEducationInfo.schoolName ?? '';
    formController.controllers[14].text = s?.personalInfo.placeOfBirth ?? '';
    enrollmentDate.value = s?.subscriptionInfo.enrollmentDate;
    exitDate.value = s?.subscriptionInfo.exitDate;
    isExempt.value = s?.subscriptionInfo.isExemptFromPayment == 1;
  }

  @override
  Future<bool> submit() async {
    return super.editController?.model.value == null
        ? await submitForm<StudentInfoDialog>(
            studentFormKey,
            studentInfo,
            ApiEndpoints.submitStudentForm,
            StudentInfoDialog.fromJson,
          )
        : await submitEditDataForm<StudentInfoDialog>(
            studentFormKey,
            studentInfo,
            ApiEndpoints.getSpecialStudent(
                editController?.model.value?.accountInfo.accountId ?? -1),
            StudentInfoDialog.fromJson,
          );
  }
}

// Session Section
class SessionSection extends StatelessWidget {
  final MultiSelectResult<Lecture>? sessionResult;
  final GenericEditController<StudentInfoDialog>? editController;
  final StudentInfoDialog studentInfo;

  const SessionSection({
    super.key,
    required this.sessionResult,
    required this.editController,
    required this.studentInfo,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      headerIcon: Icons.book,
      headerText: "session",
      child: MultiSelect<Lecture>(
        initialPickedItems: editController?.model.value?.lectures
            ?.map((e) => MultiSelectItem<Lecture>(
                  id: e.lectureId,
                  obj: e,
                  name: e.lectureNameAr,
                ))
            .toList(),
        getPickedItems: (pickedItems) {
          studentInfo.lectures = pickedItems.map((e) => e.obj).toList();
        },
        hintText: "search for sessions",
        preparedData: sessionResult?.items ?? [],
        maxSelectedItems: null,
      ),
    );
  }
}

// Personal Info Section
class PersonalInfoSection extends StatelessWidget {
  final form.FormController formController;
  final GenericEditController<StudentInfoDialog>? editController;
  final StudentInfoDialog studentInfo;
  final Generate generate;

  const PersonalInfoSection({
    super.key,
    required this.formController,
    required this.editController,
    required this.studentInfo,
    required this.generate,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      headerIcon: Icons.person,
      headerText: "Students' Personal Info",
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: InputField(
                  inputTitle: "First name in Arabic",
                  child: CustomTextField(
                    controller: formController.controllers[0],
                    validator: (value) =>
                        Validator.notEmptyValidator(value, "يجب ادخال الاسم"),
                    focusNode: formController.focusNodes[0],
                    onSaved: (p0) => studentInfo.personalInfo.firstNameAr = p0!,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: InputField(
                  inputTitle: "Last name in Arabic",
                  child: CustomTextField(
                    controller: formController.controllers[1],
                    validator: (value) =>
                        Validator.notEmptyValidator(value, "يجب ادخال الاسم"),
                    focusNode: formController.focusNodes[1],
                    onSaved: (p0) => studentInfo.personalInfo.lastNameAr = p0!,
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
                  inputTitle: "First name in Latin",
                  child: CustomTextField(
                    controller: formController.controllers[2],
                    textDirection: TextDirection.ltr,
                    onChanged: (_) => formController.controllers[6].text =
                        generate.generateUsername(formController.controllers[2],
                            formController.controllers[3]),
                    onSaved: (p0) => studentInfo.personalInfo.firstNameEn = p0,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: InputField(
                  inputTitle: "Last name in Latin",
                  child: CustomTextField(
                    controller: formController.controllers[3],
                    textDirection: TextDirection.ltr,
                    onChanged: (_) => formController.controllers[6].text =
                        generate.generateUsername(formController.controllers[2],
                            formController.controllers[3]),
                    onSaved: (p0) => studentInfo.personalInfo.lastNameEn = p0,
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
                  inputTitle: "Sex",
                  child: DropDownWidget(
                    items: sex,
                    initialValue: editController?.model.value != null
                        ? editController?.model.value?.personalInfo.sex
                        : sex[0],
                    onSaved: (p0) => studentInfo.personalInfo.sex = p0!,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: InputField(
                  inputTitle: "Date of Birth",
                  child: CustomTextField(
                    controller: formController.controllers[4],
                    onSaved: (p0) => studentInfo.personalInfo.dateOfBirth = p0,
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
                  inputTitle: "Place of Birth",
                  child: CustomTextField(
                    controller: formController.controllers[14],
                    onSaved: (p0) => studentInfo.personalInfo.placeOfBirth = p0,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: InputField(
                  inputTitle: "Address",
                  child: CustomTextField(
                    controller: formController.controllers[5],
                    onSaved: (p0) => studentInfo.personalInfo.homeAddress = p0,
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
                  inputTitle: "Nationality",
                  child: DropDownWidget(
                    items: nationalities,
                    initialValue:
                        editController?.model.value?.personalInfo.nationality ??
                            nationalities[1],
                    onSaved: (p0) => studentInfo.personalInfo.nationality = p0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Account Info Section
class AccountInfoSection extends StatelessWidget {
  final form.FormController formController;
  final StudentInfoDialog studentInfo;

  const AccountInfoSection({
    super.key,
    required this.formController,
    required this.studentInfo,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      headerIcon: Icons.account_box,
      headerText: "account info",
      child: Row(
        children: [
          Expanded(
            child: InputField(
              inputTitle: "username",
              child: CustomTextField(
                controller: formController.controllers[6],
                onSaved: (p0) => studentInfo.accountInfo.username = p0!,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: InputField(
              inputTitle: "password",
              child: CustomTextField(
                controller: formController.controllers[7],
                onSaved: (p0) => studentInfo.accountInfo.passcode = p0!,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Health Info Section
class HealthInfoSection extends StatelessWidget {
  final form.FormController formController;
  final GenericEditController<StudentInfoDialog>? editController;
  final StudentInfoDialog studentInfo;

  const HealthInfoSection({
    super.key,
    required this.formController,
    required this.editController,
    required this.studentInfo,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      headerIcon: Icons.health_and_safety,
      headerText: "health info",
      child: Row(
        children: [
          Expanded(
            child: InputField(
              inputTitle: "blood type",
              child: DropDownWidget(
                items: bloodType,
                initialValue:
                    editController?.model.value?.medicalInfo.bloodType ??
                        bloodType[0],
                onSaved: (p0) => studentInfo.medicalInfo.bloodType = p0,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: InputField(
              inputTitle: "disease causes",
              child: CustomTextField(
                controller: formController.controllers[8],
                onSaved: (p0) => studentInfo.medicalInfo.diseasesCauses = p0,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: InputField(
              inputTitle: "allergies",
              child: CustomTextField(
                controller: formController.controllers[9],
                onSaved: (p0) => studentInfo.medicalInfo.allergies = p0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Contact Info Section
class ContactInfoSection extends StatelessWidget {
  final form.FormController formController;
  final StudentInfoDialog studentInfo;

  const ContactInfoSection({
    super.key,
    required this.formController,
    required this.studentInfo,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      headerIcon: Icons.phone,
      headerText: "contact info",
      child: Row(
        children: [
          Expanded(
            child: InputField(
              inputTitle: "phone number",
              child: CustomTextField(
                controller: formController.controllers[10],
                validator: (value) => Validator.isValidPhoneNumber(value),
                focusNode: formController.focusNodes[10],
                onSaved: (p0) => studentInfo.contactInfo.phoneNumber = p0!,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: InputField(
              inputTitle: "email address",
              child: CustomTextField(
                controller: formController.controllers[11],
                validator: (value) => Validator.isValidEmail(value),
                focusNode: formController.focusNodes[11],
                onSaved: (p0) => studentInfo.contactInfo.email = p0!,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Parent Status Section
class ParentStatusSection extends StatelessWidget {
  final GenericEditController<StudentInfoDialog>? editController;
  final StudentInfoDialog studentInfo;

  const ParentStatusSection({
    super.key,
    required this.editController,
    required this.studentInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomContainer(
            headerIcon: Icons.person,
            headerText: "father state",
            child: DropDownWidget(
              items: state,
              initialValue:
                  editController?.model.value?.personalInfo.fatherStatus ??
                      state[0],
              onSaved: (p0) => studentInfo.personalInfo.fatherStatus = p0,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: CustomContainer(
            headerIcon: Icons.person,
            headerText: "mother state",
            child: DropDownWidget(
              items: state,
              initialValue:
                  editController?.model.value?.personalInfo.motherStatus ??
                      state[0],
              onSaved: (p0) => studentInfo.personalInfo.motherStatus = p0,
            ),
          ),
        ),
      ],
    );
  }
}

// Guardian Info Section
class GuardianInfoSection extends StatelessWidget {
  final MultiSelectResult? guardianResult;
  final StudentInfoDialog studentInfo;

  const GuardianInfoSection({
    super.key,
    required this.guardianResult,
    required this.studentInfo,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      headerIcon: Icons.family_restroom,
      headerText: "info about guardian",
      child: Row(
        children: [
          Expanded(
            child: InputField(
              inputTitle: "guardian's account",
              child: MultiSelect(
                getPickedItems: (pickedItems) {
                  if (pickedItems.isNotEmpty) {
                    studentInfo.guardian.guardianId = pickedItems[0].id;
                  }
                },
                preparedData: guardianResult?.items ?? [],
                hintText: "search for guardian account",
                maxSelectedItems: 1,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: OutlinedButton(
              onPressed: () async {
                Get.put(form.FormController(5), tag: "guardian");
                Get.put(Generate());
                Get.dialog(const GuardianDialogLite());
              },
              child: const Text("Add Guardian"),
            ),
          ),
        ],
      ),
    );
  }
}

// Subscription Info Section
class SubscriptionInfoSection extends StatelessWidget {
  final form.FormController formController;
  final GenericEditController<StudentInfoDialog>? editController;
  final StudentInfoDialog studentInfo;
  final Rx<String?> enrollmentDate;
  final Rx<String?> exitDate;
  final RxBool isExempt;

  const SubscriptionInfoSection({
    super.key,
    required this.formController,
    required this.editController,
    required this.studentInfo,
    required this.enrollmentDate,
    required this.exitDate,
    required this.isExempt,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      headerText: "subscription information",
      headerIcon: Icons.subscriptions,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: InputField(
                  inputTitle: "enrollment date",
                  child: Obx(
                    () => OutlinedButton(
                      onPressed: () async {
                        await dateSelector(context).then((value) {
                          if (value != null) {
                            enrollmentDate.value = value;
                            studentInfo.subscriptionInfo.enrollmentDate = value;
                          }
                        });
                      },
                      child: Text(enrollmentDate.value ?? "select date"),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InputField(
                  inputTitle: "is exempt from payment",
                  child: DropDownWidget<bool>(
                    items: trueFalse,
                    initialValue: editController?.model.value?.subscriptionInfo
                                .isExemptFromPayment ==
                            1
                        ? true
                        : false,
                    onChanged: (p0) {
                      isExempt.value = p0!;
                      dev.log("isExempt: $isExempt");
                    },
                    onSaved: (p0) =>
                        studentInfo.subscriptionInfo.isExemptFromPayment = p0,
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
                          initialValue: editController?.model.value
                                  ?.subscriptionInfo.exemptionPercentage ??
                              exemptionPercentage[0],
                          onChanged: (p0) {
                            studentInfo.subscriptionInfo.exemptionPercentage =
                                isExempt.value ? p0 : null;
                          },
                          onSaved: (p0) => studentInfo
                              .subscriptionInfo.exemptionPercentage = p0,
                        ),
                      ),
                    ),
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
                  inputTitle: "exit date",
                  child: Obx(
                    () => OutlinedButton(
                      onPressed: () async {
                        await dateSelector(context).then((value) {
                          if (value != null) {
                            exitDate.value = value;
                            studentInfo.subscriptionInfo.exitDate = value;
                          }
                        });
                      },
                      child: Text(exitDate.value ?? "select date"),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InputField(
                  inputTitle: "exit reason",
                  child: CustomTextField(
                    controller: formController.controllers[12],
                    onSaved: (p0) =>
                        studentInfo.subscriptionInfo.exitReason = p0,
                    maxLines: 3,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Formal Education Section
class FormalEducationSection extends StatelessWidget {
  final form.FormController formController;
  final GenericEditController<StudentInfoDialog>? editController;
  final StudentInfoDialog studentInfo;

  const FormalEducationSection({
    super.key,
    required this.formController,
    required this.editController,
    required this.studentInfo,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      headerText: "formal education",
      headerIcon: Icons.school,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: InputField(
                  inputTitle: "school type",
                  child: DropDownWidget(
                    items: schoolType,
                    initialValue: editController
                            ?.model.value?.formalEducationInfo.schoolType ??
                        schoolType[0],
                    onSaved: (p0) =>
                        studentInfo.formalEducationInfo.schoolType = p0,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: InputField(
                  inputTitle: "school name",
                  child: CustomTextField(
                    controller: formController.controllers[13],
                    onSaved: (p0) =>
                        studentInfo.formalEducationInfo.schoolName = p0,
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
                    initialValue: editController
                            ?.model.value?.formalEducationInfo.academicLevel ??
                        academicLevel[0],
                    onSaved: (p0) =>
                        studentInfo.formalEducationInfo.academicLevel = p0,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: InputField(
                  inputTitle: "grade",
                  child: DropDownWidget(
                    initialValue: editController
                            ?.model.value?.formalEducationInfo.grade ??
                        grades[0],
                    items: grades,
                    onSaved: (p0) => studentInfo.formalEducationInfo.grade = p0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

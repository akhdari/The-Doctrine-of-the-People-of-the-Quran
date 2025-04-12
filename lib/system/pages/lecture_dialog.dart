import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../connect/get_teachers.dart';
import '/system/const/lecture_const.dart';
import '../widgets/drop_down.dart';
import '../../logic/submit_form.dart';
import '../const/lecture_class.dart';
import '../connect/connect.dart';
import '../../logic/validators.dart';
import '../widgets/containers.dart';
import '../widgets/input_field.dart';
import '../widgets/custom_matrix.dart';
import '../widgets/multiselect.dart';
import 'package:multiple_search_selection/multiple_search_selection.dart';
import 'dart:developer' as dev;

const String url = 'http://192.168.100.20/phpscript/get_lecture.php';

class LectureDialog extends StatefulWidget {
  const LectureDialog({super.key});

  @override
  State<LectureDialog> createState() => _LectureDialogState();
}

class _LectureDialogState extends State<LectureDialog> {
  Future<void> loadData() async {
    try {
      final fetchedTeachernNames = await getTeachers();

      dev.log('teacherNames: ${fetchedTeachernNames.toString()}');

      setState(() {
        teacherNames = fetchedTeachernNames;
        dev.log('teacherNames: ${teacherNames.toString()}');
      });
    } catch (e) {
      dev.log("Error loading data: $e");
    }
  }

  final GlobalKey<FormState> lectureFormKey = GlobalKey<FormState>();
  late ScrollController scrollController;
  late Validator validator;
  final Connect connect = Connect();
  final lectureInfo = Lecture();
  late MultipleSearchController multiSearchController;
  late List<Map<String, dynamic>> teacherNames = [];

  @override
  void initState() {
    validator = Get.find<Validator>(tag: "lecturePage");
    scrollController = ScrollController();
    multiSearchController = MultipleSearchController(
      minCharsToShowItems: 1,
      allowDuplicateSelection: false,
    );
    loadData();
    Get.put(TimeCellController());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TimeCellController timeCellController =
        Get.find<TimeCellController>();
    return Scaffold(
      body: ConstrainedBox(
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
                      key: lectureFormKey,
                      child: Column(
                        children: [
                          CustomContainer(
                            title: "lecture info",
                            icon: Icons.person,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: InputField(
                                        inputTitle: "lecture name in arabic",
                                        child: CustomTextField(
                                          controller: validator.controllers[0],
                                          validator:
                                              validator.notEmptyValidator(
                                                  "يجب ادخال الاسم"),
                                          focusNode: validator.focusNodes[0],
                                          onSaved: (p0) =>
                                              lectureInfo.lectureNameAr = p0!,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: InputField(
                                        inputTitle: "lecture name in english",
                                        child: CustomTextField(
                                          controller: validator.controllers[1],
                                          validator:
                                              validator.notEmptyValidator(
                                                  "يجب ادخال الاسم"),
                                          focusNode: validator.focusNodes[1],
                                          onSaved: (p0) =>
                                              lectureInfo.lectureNameEn = p0!,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: InputField(
                                        inputTitle: "lecture type",
                                        child: DropDownWidget(
                                          items: type,
                                          initialValue: type[0],
                                          onSaved: (p0) =>
                                              lectureInfo.circleType = p0!,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: InputField(
                                        inputTitle: "category",
                                        child: DropDownWidget(
                                          items: category,
                                          initialValue: null,
                                          onSaved: (p0) =>
                                              lectureInfo.category = p0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                InputField(
                                  inputTitle: "teachers",
                                  child: DefaultConstructorExample(
                                    multipleSearchController:
                                        multiSearchController,
                                    pickedItems: (p0) =>
                                        lectureInfo.teacherNames = p0,
                                    searchkey: "full_name",
                                    preparedData: teacherNames,
                                    hintText: "search by teacher name",
                                    maxSelectedItems: null,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                InputField(
                                    inputTitle: "show on website?",
                                    child: DropDownWidget(
                                      items: trueFalse,
                                      initialValue: trueFalse[1],
                                      onSaved: (p0) => lectureInfo
                                          .showOnwebsite = transformBool(p0!),
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomContainer(
                            icon: Icons.alarm,
                            title: "schedule info",
                            child: CustomMatrix(
                              controller: timeCellController,
                            ),
                          ),
                          SizedBox(height: 10),
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
                      validator.moveToTheFirstEmptyFeild(lectureFormKey);
                      lectureInfo.schedule =
                          timeCellController.getSelectedDays();
                      dev.log(lectureInfo.schedule.toString());
                      submitForm(
                        lectureFormKey,
                        connect,
                        lectureInfo,
                        url,
                      );
                    },
                    child: const Text("Submit"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

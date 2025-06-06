import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as dev;

import 'package:the_doctarine_of_the_ppl_of_the_quran/system/models/post/lecture.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/teacher.dart';

//TODO
//category
// teacher ids
// show on website, isBool
class EditLecture extends GetxController {
  final Rx<LectureForm?> lecture;

  bool isEdit = false;
  late final TextEditingController lectureNameAr;
  late final TextEditingController lectureNameEn;
  late String lectureType;
  final RxList<Teacher> teacherIds = <Teacher>[].obs;

  EditLecture({required LectureForm? initialLecture, required this.isEdit})
      : lecture = initialLecture.obs,
        lectureNameAr =
            TextEditingController(text: initialLecture?.lecture.lectureNameAr),
        lectureNameEn =
            TextEditingController(text: initialLecture?.lecture.lectureNameEn) {
    // Initialize the values
    lectureType = initialLecture?.lecture.circleType ?? '';
    teacherIds.value = initialLecture?.teachers ?? <Teacher>[];

    ever(lecture, (_) {
      lectureNameAr.text = lecture.value?.lecture.lectureNameAr;
      dev.log("lectureNameAr in EditLecture: ${lectureNameAr.text}");
      lectureNameEn.text = lecture.value?.lecture.lectureNameEn;
      dev.log("lectureNameEn in EditLecture: ${lectureNameEn.text}");
      lectureType = lecture.value?.lecture.circleType;
      teacherIds.value = lecture.value?.teachers ?? <Teacher>[];
      update();
    });
  }

  void updateLecture(LectureForm newLecture) {
    lecture.value = newLecture;
  }

  @override
  void onClose() {
    lectureNameAr.dispose();
    lectureNameEn.dispose();
    super.onClose();
  }
}
/*  EditLecture({required this.lecture, required this.isEdit})
      : lectureNameAr = TextEditingController(text: lecture.lectureNameAr),
        lectureNameEn = TextEditingController(text: lecture.lectureNameEn),
        lectureType = lecture.circleType,
        teacherIds = lecture.teacherIds {
    dev.log(teacherIds.toString());
  }*/

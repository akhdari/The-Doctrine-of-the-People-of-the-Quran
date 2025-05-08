import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/models/get/lecture_class.dart';
import 'dart:developer' as dev;

//TODO
//category
// teacher ids
// show on website, isBool
class EditLecture extends GetxController {
  final Rx<Lecture> lecture;

  bool isEdit = false;
  late final TextEditingController lectureNameAr;
  late final TextEditingController lectureNameEn;
  late String lectureType;
  final RxList<String> teacherIds = <String>[].obs;

  EditLecture({required Lecture initialLecture, required this.isEdit})
      : lecture = initialLecture.obs,
        lectureNameAr =
            TextEditingController(text: initialLecture.lectureNameAr),
        lectureNameEn =
            TextEditingController(text: initialLecture.lectureNameEn) {
    // Initialize the values
    lectureType = initialLecture.circleType;
    teacherIds.value = initialLecture.teacherIds;

    ever(lecture, (_) {
      lectureNameAr.text = lecture.value.lectureNameAr;
      dev.log("lectureNameAr in EditLecture: ${lecture.value.lectureNameAr}");
      lectureNameEn.text = lecture.value.lectureNameEn;
      dev.log("lectureNameEn in EditLecture: ${lecture.value.lectureNameEn}");
      lectureType = lecture.value.circleType;
      teacherIds.value = lecture.value.teacherIds;
      update();
    });
  }

  void updateLecture(Lecture newLecture) {
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

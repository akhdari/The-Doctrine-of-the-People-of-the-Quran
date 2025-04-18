import 'abstract_class.dart';

class Lecture extends AbstractClass {
  //lecture info
  //required
  late String lectureNameAr;
  late String lectureNameEn;
  late String circleType;
  late List<int> teachersId;
  late int showOnwebsite;
  late String category; //drop down

  //lecture schedule
  Map<String, Map<String, dynamic>>? schedule;

  @override
  bool get isComplete {
    return lectureNameAr.isNotEmpty &&
        lectureNameEn.isNotEmpty &&
        circleType.isNotEmpty &&
        teachersId.isNotEmpty &&
        schedule != null;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "info": {
        "lecture_name_ar": lectureNameAr,
        "lecture_name_en": lectureNameEn,
        "circle_type": circleType,
        "category": category,
        "teacher_ids": teachersId,
        "show_on_website": showOnwebsite
      },
      "schedule": schedule,
    };
  }
}

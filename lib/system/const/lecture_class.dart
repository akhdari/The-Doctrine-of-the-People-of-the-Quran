import 'abstract_class.dart';

class Lecture extends AbstractClass {
  //lecture info
  //required
  late String lectureNameAr;
  late String lectureNameEn;
  //optional
  String? circleType;
  List<String>? teacherNames = [];
  int? showOnwebsite;
  String? category;

  //lecture schedule
  Map<String, Map<String, dynamic>>? schedule;

  @override
  bool get isComplete {
    return lectureNameAr.isNotEmpty && lectureNameEn.isNotEmpty;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "info": {
        "lecture_name_ar": lectureNameAr,
        "lecture_name_en": lectureNameEn,
        "circle_type": circleType,
        "category": category,
        "teacher_names": teacherNames,
        "show_on_website": showOnwebsite
      },
      "schedule": schedule,
    };
  }
}

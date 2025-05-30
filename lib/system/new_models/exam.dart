import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/model.dart';class Exam implements Model {
  dynamic examId;
  dynamic examLevelId;
  dynamic examNameAr;
  dynamic examNameEn;
  dynamic examType;
  dynamic examSucessMinPoint;
  dynamic examMaxPoint;

  Exam({
    this.examId,
    this.examLevelId,
    this.examNameAr,
    this.examNameEn,
    this.examType,
    this.examSucessMinPoint,
    this.examMaxPoint,
  });

  factory Exam.fromJson(Map<String, dynamic> json) => Exam(
    examId: json['exam_id'],
    examLevelId: json['exam_level_id'],
    examNameAr: json['exam_name_ar'],
    examNameEn: json['exam_name_en'],
    examType: json['exam_type'],
    examSucessMinPoint: json['exam_sucess_min_point'],
    examMaxPoint: json['exam_max_point'],
  );

  @override
  Map<String, dynamic> toJson() => {
    'exam_id': examId,
    'exam_level_id': examLevelId,
    'exam_name_ar': examNameAr,
    'exam_name_en': examNameEn,
    'exam_type': examType,
    'exam_sucess_min_point': examSucessMinPoint,
    'exam_max_point': examMaxPoint,
  };
}


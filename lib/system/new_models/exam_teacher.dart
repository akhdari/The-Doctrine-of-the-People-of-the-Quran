import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/model.dart';class ExamTeacher implements Model {
  dynamic examId;
  dynamic teacherId;
  dynamic pointHifd;
  dynamic pointTajwidApplicative;
  dynamic pointTajwidTheoric;
  dynamic pointPerformance;
  dynamic pointDeductionTal;
  dynamic pointDeductionTanbihi;
  dynamic pointDeductionTajwidi;
  dynamic date;

  ExamTeacher({
    this.examId,
    this.teacherId,
    this.pointHifd,
    this.pointTajwidApplicative,
    this.pointTajwidTheoric,
    this.pointPerformance,
    this.pointDeductionTal,
    this.pointDeductionTanbihi,
    this.pointDeductionTajwidi,
    this.date,
  });

  factory ExamTeacher.fromJson(Map<String, dynamic> json) => ExamTeacher(
    examId: json['exam_id'],
    teacherId: json['teacher_id'],
    pointHifd: json['point_hifd'],
    pointTajwidApplicative: json['point_tajwid_applicative'],
    pointTajwidTheoric: json['point_tajwid_theoric'],
    pointPerformance: json['point_performance'],
    pointDeductionTal: json['point_deduction_tal'],
    pointDeductionTanbihi: json['point_deduction_tanbihi'],
    pointDeductionTajwidi: json['point_deduction_tajwidi'],
    date: json['date'],
  );

  @override
  Map<String, dynamic> toJson() => {
    'exam_id': examId,
    'teacher_id': teacherId,
    'point_hifd': pointHifd,
    'point_tajwid_applicative': pointTajwidApplicative,
    'point_tajwid_theoric': pointTajwidTheoric,
    'point_performance': pointPerformance,
    'point_deduction_tal': pointDeductionTal,
    'point_deduction_tanbihi': pointDeductionTanbihi,
    'point_deduction_tajwidi': pointDeductionTajwidi,
    'date': date,
  };
}


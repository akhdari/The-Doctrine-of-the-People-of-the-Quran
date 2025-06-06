import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/exam.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/exam_student.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/personal_info.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/student.dart';

import 'abstract_class.dart';

class ExamRecordInfoDialog extends AbstractClass {
  Exam exam = Exam();
  Student student = Student();
  PersonalInfo personalInfo = PersonalInfo();
  ExamStudent examStudent = ExamStudent();

  ExamRecordInfoDialog();
  @override
  bool get isComplete {
    return exam.examType.isNotEmpty &&
        examStudent.dateTakeExam.isNotEmpty &&
        student.studentId != null &&
        personalInfo.firstNameAr.isNotEmpty &&
        personalInfo.lastNameAr.isNotEmpty;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'exam': exam.toJson(),
      'student': student.toJson(),
      'personal_info': personalInfo.toJson(),
      'exam_student': examStudent.toJson(),
    };
  }

  ExamRecordInfoDialog.fromMap(Map<String, dynamic> map) {
    exam = Exam.fromJson(map['exam']);
    student = Student.fromJson(map['student']);
    personalInfo = PersonalInfo.fromJson(map['personal_info']);
    examStudent = ExamStudent.fromJson(map['exam_student']);
  }
}

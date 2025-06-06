import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/exam.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/teacher.dart';

import 'abstract_class.dart';

class ExamTeacherInfoDialog extends AbstractClass {
  List<Exam> exam = [];
  Teacher techer = Teacher();

  ExamTeacherInfoDialog();
  @override
  bool get isComplete {
    return exam.isEmpty &&
        techer.teacherId != null &&
        techer.firstName.isNotEmpty &&
        techer.lastName.isNotEmpty;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'exam': exam.map((e) => e.toJson()).toList(),
      'teacher': techer.toJson(),
    };
  }

  ExamTeacherInfoDialog.fromMap(Map<String, dynamic> map) {
    exam = (map['exam'] as List)
        .map((e) => Exam.fromJson(e as Map<String, dynamic>))
        .toList();
    techer = Teacher.fromJson(map['teacher']);
  }
}

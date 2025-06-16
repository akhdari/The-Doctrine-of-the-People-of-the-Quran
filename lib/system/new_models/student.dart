import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/model.dart';

class Student implements Model {
  dynamic studentId;
  dynamic guardianId;
  dynamic studentContactId;
  dynamic studentAccountId;

//
  Student({
    this.studentId,
    this.guardianId,
    this.studentContactId,
    this.studentAccountId,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        studentId: json['student_id'],
        guardianId: json['guardian_id'],
        studentContactId: json['student_contact_id'],
        studentAccountId: json['student_account_id'],
      );

  @override
  Map<String, dynamic> toJson() => {
        'student_id': studentId,
        'guardian_id': guardianId,
        'student_contact_id': studentContactId,
        'student_account_id': studentAccountId,
      };

  @override
  List<int> getPrimaryKey() => [studentId, guardianId];
}

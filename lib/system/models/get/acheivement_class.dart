import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/model.dart';

class Acheivement implements Model {
  String studentID;
  String studentName;
  Acheivement({required this.studentID, required this.studentName});
  String getStudentName() => studentName;
  String getId() => studentID;
  factory Acheivement.fromJson(Map<String, dynamic> json) => Acheivement(
        studentID: json['student_id'].toString(),
        studentName: json['full_name'],
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      'student_id': studentID,
      'full_name': studentName,
    };
  }
}

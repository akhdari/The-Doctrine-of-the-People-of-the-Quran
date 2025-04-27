class Acheivement {
  String studentID;
  String studentName;
  Acheivement({required this.studentID, required this.studentName});
  String getStudentName() => studentName;
  String getId() => studentID;
  factory Acheivement.fromJson(Map<String, dynamic> json) => Acheivement(
        studentID: json['student_id'].toString(),
        studentName: json['full_name'],
      );
}

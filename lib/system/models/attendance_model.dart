import 'package:get/get.dart';

enum AttendanceStatus { present, absent, late, excused, none }

class Student {
  final String id;
  final String name;
  Student({required this.id, required this.name});
}

class Lecture {
  final String id;
  final String name;
  Lecture({required this.id, required this.name});
}

class StudentAttendance {
  final Student student;
  late Rx<AttendanceStatus> status;

  StudentAttendance({
    required this.student,
    AttendanceStatus initialStatus = AttendanceStatus.none,
  }) {
    status = initialStatus.obs;
  }
}

import 'connect.dart';

const url = 'http://192.168.100.20/phpscript/teachers.php';

class TeacherResult {
  List<Teacher>? teachers;
  String? errorMessage;
  TeacherResult.onSuccess({required this.teachers}) : errorMessage = null;
  TeacherResult.onError({required this.errorMessage}) : teachers = null;
}

class Teacher {
  final String id;
  final String name;

  Teacher({required this.id, required this.name});
  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json['teacher_id'],
      name: json['full_name'],
    );
  }
}

Future<TeacherResult> getTeachers() async {
  Connect connect = Connect();
  ApiResult<List<Map<String, dynamic>>> data;

  List<Map<String, dynamic>> teachers;
  List<Teacher> teacherList;
  data = await connect.get(url);
  if (data.isSuccess) {
    teachers = data.data!;

    teacherList = teachers.map((item) => Teacher.fromJson(item)).toList();
    return TeacherResult.onSuccess(teachers: teacherList);
  } else {
    return TeacherResult.onError(errorMessage: data.errorMessage);
  }
}

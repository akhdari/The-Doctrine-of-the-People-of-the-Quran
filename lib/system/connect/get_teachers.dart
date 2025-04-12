import '/system/connect/connect.dart';

const url = 'http://192.168.100.20/phpscript/teachers.php';

Future<List<Map<String, dynamic>>> getTeachers() async {
  Connect connect = Connect();

  List<Map<String, dynamic>> teachers;
  teachers = await connect.get(url);
  return teachers;
}

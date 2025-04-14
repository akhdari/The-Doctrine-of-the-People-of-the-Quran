import '/system/connect/connect.dart';

const url = 'http://192.168.100.20/phpscript/teachers.php';

Future<List<Map<String, dynamic>>> getTeachers() async {
  Connect connect = Connect();
  ApiResult<List<Map<String, dynamic>>> data;

  List<Map<String, dynamic>> teachers;
  data = await connect.get(url);
  if (data.isSuccess) {
    teachers = data.data!;
    return teachers;
  } else {
    return [
      {"error message": data.errorMessage},
      {"error code": data.errorCode}
    ];
  }
}

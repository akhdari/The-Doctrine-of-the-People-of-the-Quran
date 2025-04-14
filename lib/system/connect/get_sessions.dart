import '/system/connect/connect.dart';

const url = 'http://192.168.100.20/phpscript/sessions.php';

Future<List<Map<String, dynamic>>> getSessions() async {
  Connect connect = Connect();
  ApiResult<List<Map<String, dynamic>>> data;
  List<Map<String, dynamic>> sessions;
  data = await connect.get(url);

  if (data.isSuccess) {
    sessions = data.data!;
    return sessions;
  } else {
    return [
      {"error message": data.errorMessage},
      {"error code": data.errorCode}
    ];
  }
}

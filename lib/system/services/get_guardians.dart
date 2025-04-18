import 'connect.dart';

const url = 'http://192.168.100.20/phpscript/guardians.php';

Future<List<Map<String, dynamic>>> getGuardians() async {
  Connect connect = Connect();

  ApiResult<List<Map<String, dynamic>>> data;
  List<Map<String, dynamic>> guardians;

  data = await connect.get(url);
  if (data.isSuccess) {
    guardians = data.data!;
    return guardians;
  } else {
    return [
      {"error message": data.errorMessage},
      {"error code": data.errorCode}
    ];
  }
}

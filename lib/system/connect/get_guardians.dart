import '/system/connect/connect.dart';

const url = 'http://192.168.100.20/phpscript/guardians.php';

Future<List<Map<String, dynamic>>> getGuardians() async {
  Connect connect = Connect();

  List<Map<String, dynamic>> guardians;
  guardians = await connect.get(url);
  return guardians;
}

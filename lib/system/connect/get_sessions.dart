import '/system/connect/connect.dart';

const url = 'http://192.168.100.20/phpscript/sessions.php';

Future<List<Map<String, dynamic>>> getSessions() async {
  Connect connect = Connect();

  List<Map<String, dynamic>> sessions;
  sessions = await connect.get(url);
  return sessions;
}

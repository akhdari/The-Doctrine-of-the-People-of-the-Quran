import 'package:flutter/material.dart';
import '/system/connect/connect.dart';

const url = 'http://192.168.100.20/phpscript/sessions.php';
TextStyle kStyleDefault = const TextStyle(
  color: Colors.black,
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

class Session {
  late String name;
  Session({required this.name});
//TODO tostring
}

Future<List<Map<String, dynamic>>> getSessions() async {
  Connect connect = Connect();

  List<Map<String, dynamic>> sessions;
  sessions = await connect.get(url);
  return sessions;
}

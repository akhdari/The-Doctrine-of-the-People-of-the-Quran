import 'dart:convert';
//import './class.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;

class Connect {
  Future<Map<String, dynamic>?> get(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
//jsonDecode() and jsonEncode() handle converting between JSON strings and Dart data types
//fromJson and toJson are needed for working with custom objects in Dart.
//json string -> decode -> from json
//dart obj -> encode -> to json
        Map<String, dynamic> json =
            jsonDecode(response.body) as Map<String, dynamic>;
        log(json.toString());
        return json;
        //return Student.fromJson(json);
      } else {
        throw Exception('request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}

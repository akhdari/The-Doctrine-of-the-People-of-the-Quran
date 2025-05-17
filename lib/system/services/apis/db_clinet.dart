import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/model.dart';

class HttpClient {
  static const String baseUrl =
      "http://localhost:8000/dev_run/Project/ahl_quran_backend";

  static Map<String, String> get headers => {
        'Content-Type': 'application/json',
        // Add other default headers here if needed
      };

  static Future<http.Response> get(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    return await http.get(url, headers: headers);
  }

  static Future<http.Response> post(String endpoint,
      {required Model body, Encoding? encoding}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    return await http.post(url,
        headers: headers, body: body.toJson(), encoding: encoding);
  }

  static Future<http.Response> put(String endpoint,
      {required Model body, Encoding? encoding}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    return await http.put(url,
        headers: headers, body: body, encoding: encoding);
  }

  static Future<http.Response> delete(String endpoint,
      {required Model body, Encoding? encoding}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    return await http.delete(url,
        headers: headers, body: body, encoding: encoding);
  }

  static Future<http.Response> patch(String endpoint,
      {required Model body, Encoding? encoding}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    return await http.patch(url,
        headers: headers, body: body.toJson(), encoding: encoding);
  }
}

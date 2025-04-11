import 'dart:convert';
import 'package:http/http.dart' as http;
import '../const/abstract_class.dart';
import 'dart:developer' as dev;

class Connect {
  Future<List<Map<String, dynamic>>> get(String url) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse =
            json.decode(response.body) as List<dynamic>;
        final List<Map<String, dynamic>> listOfMaps = jsonResponse
            .cast<Map<String, dynamic>>()
            .map((map) => map.map((key, value) =>
                MapEntry(key, value ?? ''))) // Replace null with ''
            .toList();
        return listOfMaps;
      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } on FormatException catch (e) {
      throw FormatException('Invalid JSON format: $e');
    } on http.ClientException catch (e) {
      throw http.ClientException('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future post(String url, AbstractClass obj) async {
    try {
      final requestBody = json.encode(obj.toMap());
      dev.log("Request Body: $requestBody");
      final response = await http.post(Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(obj.toMap()));

      if (response.statusCode == 200) {
        dev.log(jsonEncode(obj.toMap()));
        dev.log("you seccusfully added data to the backend");
        return json.decode(response.body);
      } else if (response.statusCode == 400) {
        throw Exception("end point not found");
      } else if (response.statusCode == 500) {
        throw Exception("server error");
      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } on FormatException catch (e) {
      throw FormatException('Invalid JSON format: $e');
    } on http.ClientException catch (e) {
      throw http.ClientException('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}

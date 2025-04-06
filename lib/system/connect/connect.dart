import 'dart:convert';
import 'package:http/http.dart' as http;

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
}

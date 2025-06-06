import 'dart:convert';
import 'dart:developer' as code;
import 'package:http/http.dart' as http;

class ApiService {
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json'
  };

  static Uri _buildUri(String endpoint) => Uri.parse(endpoint);

  static void _log(String message) {
    // You can replace this with any logger you prefer
    code.log('[ApiService] $message');
  }

  // --- GET single object ---
  static Future<T> fetchObject<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    _log('GET $endpoint');
    final response =
        await http.get(_buildUri(endpoint), headers: defaultHeaders);

    _log('Response (${response.statusCode}): ${response.body}');
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return fromJson(data);
    } else {
      throw Exception('GET $endpoint failed: ${response.statusCode}');
    }
  }

  // --- GET list of objects ---
  static Future<List<T>> fetchList<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    _log('GET $endpoint');
    final response =
        await http.get(_buildUri(endpoint), headers: defaultHeaders);

    _log('Response (${response.statusCode}): ${response.body}');
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data is List) {
        return data.map((item) => fromJson(item)).toList();
      } else if (data['data'] is List) {
        return (data['data'] as List).map((item) => fromJson(item)).toList();
      } else {
        throw Exception('Expected a list but got: $data');
      }
    } else {
      throw Exception('GET $endpoint failed: ${response.statusCode}');
    }
  }

  // --- POST ---
  static Future<T> post<T>(
    String endpoint,
    Map<String, dynamic> body,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    _log('POST $endpoint\nBody: $body');
    final response = await http.post(
      _buildUri(endpoint),
      headers: defaultHeaders,
      body: json.encode(body),
    );

    _log('Response (${response.statusCode}): ${response.body}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body);
      return fromJson(data);
    } else {
      throw Exception('POST $endpoint failed: ${response.statusCode}');
    }
  }

  // --- PUT ---
  static Future<T> put<T>(
    String endpoint,
    Map<String, dynamic> body,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    _log('PUT $endpoint\nBody: $body');
    final response = await http.put(
      _buildUri(endpoint),
      headers: defaultHeaders,
      body: json.encode(body),
    );

    _log('Response (${response.statusCode}): ${response.body}');
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return fromJson(data);
    } else {
      throw Exception(
          'PUT $endpoint failed: ${response.statusCode} - ${response.body}');
    }
  }

  // --- PATCH ---
  static Future<T> patch<T>(
    String endpoint,
    Map<String, dynamic> body,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    _log('PATCH $endpoint\nBody: $body');
    final response = await http.patch(
      _buildUri(endpoint),
      headers: defaultHeaders,
      body: json.encode(body),
    );

    _log('Response (${response.statusCode}): ${response.body}');
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return fromJson(data);
    } else {
      throw Exception('PATCH $endpoint failed: ${response.statusCode}');
    }
  }

  // --- DELETE ---
  static Future<void> delete(String endpoint) async {
    _log('DELETE $endpoint');
    final response =
        await http.delete(_buildUri(endpoint), headers: defaultHeaders);

    _log('Response (${response.statusCode}): ${response.body}');
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('DELETE $endpoint failed: ${response.statusCode}');
    }
  }
}

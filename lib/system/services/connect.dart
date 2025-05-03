import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post/abstract_class.dart';
import 'dart:developer' as dev;

class ApiResult<T> {
  final String? errorMessage;
  final String? errorCode;
  final T? data;
  ApiResult.seccess({required this.data})
      : errorMessage = null,
        errorCode = null;
  ApiResult.failure({this.errorCode, this.errorMessage}) : data = null;
  bool get isSuccess {
    return data != null;
  }
}

class Connect {
  static const Duration _timeoutDuration = Duration(seconds: 8);
  static const Duration _connectionTimeout = Duration(seconds: 5);
  String? errorMessage;
  String? errorCode;

  List<Map<String, dynamic>> parseJsonList(http.Response response) {
    try {
      final List<dynamic> jsonResponse =
          json.decode(response.body) as List<dynamic>;
      final List<Map<String, dynamic>> listOfMaps = jsonResponse
          .cast<Map<String, dynamic>>()
          .map((map) => map.map((key, value) => MapEntry(key, value ?? '')))
          .toList();
      return listOfMaps;
    } catch (e) {
      dev.log('Error parsing JSON: $e');
      throw FormatException('Failed to parse response data');
    }
  }

  Future<ApiResult<List<Map<String, dynamic>>>> get(String url) async {
    try {
      dev.log('Fetching data from: $url');

      // Create a client with connection timeout
      final client = http.Client();
      final request = http.Request('GET', Uri.parse(url))
        ..headers['Accept'] = 'application/json';

      // Try to establish connection first
      try {
        await client.send(request).timeout(_connectionTimeout);
      } catch (e) {
        client.close();
        dev.log('Connection failed: $e');
        return ApiResult.failure(
          errorMessage:
              'Could not connect to server. Please check your connection.',
        );
      }

      // If connection successful, make the actual request
      final response = await client.get(
        Uri.parse(url),
        headers: {'Accept': 'application/json'},
      ).timeout(_timeoutDuration);

      client.close();
      dev.log("Response status: ${response.statusCode}");
      dev.log("Response body: ${response.body}");

      if (response.statusCode == 200) {
        return ApiResult.seccess(data: parseJsonList(response));
      } else {
        return ApiResult.failure(
          errorCode: response.statusCode.toString(),
          errorMessage: response.body,
        );
      }
    } on FormatException catch (e) {
      dev.log('Format error: ${e.message}');
      return ApiResult.failure(
          errorMessage: 'Invalid response format: ${e.message}');
    } on http.ClientException catch (e) {
      dev.log('Network error: ${e.message}');
      return ApiResult.failure(
          errorMessage:
              'Could not connect to server. Please check your connection.');
    } on TimeoutException catch (e) {
      dev.log('Timeout error: ${e.message}');
      return ApiResult.failure(
          errorMessage:
              'Server is taking too long to respond. Please try again.');
    } catch (e) {
      dev.log('Unknown error: $e');
      return ApiResult.failure(
          errorMessage: 'Could not connect to server. Please try again.');
    }
  }

  Future<ApiResult<dynamic>> post(String url, AbstractClass obj) async {
    try {
      final requestBody = json.encode(obj.toMap());
      dev.log('Sending POST request to: $url');
      dev.log('Request body: $requestBody');

      // Create a client with connection timeout
      final client = http.Client();
      final request = http.Request('POST', Uri.parse(url))
        ..headers['Content-Type'] = 'application/json'
        ..body = requestBody;

      // Try to establish connection first
      try {
        await client.send(request).timeout(_connectionTimeout);
      } catch (e) {
        client.close();
        dev.log('Connection failed: $e');
        return ApiResult.failure(
          errorMessage:
              'Could not connect to server. Please check your connection.',
        );
      }

      // If connection successful, make the actual request
      final response = await client
          .post(
            Uri.parse(url),
            headers: {'Content-Type': 'application/json'},
            body: requestBody,
          )
          .timeout(_timeoutDuration);

      client.close();
      dev.log('Response status: ${response.statusCode}');
      dev.log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        return ApiResult.seccess(data: json.decode(response.body));
      } else if (response.statusCode == 400) {
        return ApiResult.failure(
          errorCode: response.statusCode.toString(),
          errorMessage: 'Invalid request: ${response.body}',
        );
      } else if (response.statusCode == 500) {
        return ApiResult.failure(
          errorCode: response.statusCode.toString(),
          errorMessage: 'Server error: ${response.body}',
        );
      } else {
        return ApiResult.failure(
          errorCode: response.statusCode.toString(),
          errorMessage: response.body,
        );
      }
    } on FormatException catch (e) {
      dev.log('Format error: ${e.message}');
      return ApiResult.failure(
          errorMessage: 'Invalid response format: ${e.message}');
    } on http.ClientException catch (e) {
      dev.log('Network error: ${e.message}');
      return ApiResult.failure(
          errorMessage:
              'Could not connect to server. Please check your connection.');
    } on TimeoutException catch (e) {
      dev.log('Timeout error: ${e.message}');
      return ApiResult.failure(
          errorMessage:
              'Server is taking too long to respond. Please try again.');
    } catch (e) {
      dev.log('Unknown error: $e');
      return ApiResult.failure(
          errorMessage: 'Could not connect to server. Please try again.');
    }
  }
}

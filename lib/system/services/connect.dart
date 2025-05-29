import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post/abstract_class.dart';
import 'dart:developer' as dev;

class ApiResult<T> {
  final String? errorMessage;
  final String? errorCode;
  final T? data;

  ApiResult.success({required this.data})
      : errorMessage = null,
        errorCode = null;

  ApiResult.failure({this.errorCode, this.errorMessage}) : data = null;

  bool get isSuccess => data != null;
}

class Connect {
  static const Duration _timeoutDuration = Duration(seconds: 8);
  static const Duration _connectionTimeout = Duration(seconds: 5);

  Future<ApiResult<List<Map<String, dynamic>>>> get(String url) async {
    final result = await _sendRequest(
      url,
      'GET',
      headers: {'Accept': 'application/json; charset=utf-8'},
    );

    if (!result.isSuccess) {
      return ApiResult.failure(
        errorCode: result.errorCode,
        errorMessage: result.errorMessage,
      );
    }

    try {
      final responseBody = utf8.decode(json.encode(result.data).codeUnits);
      final Map<String, dynamic> jsonResponse = json.decode(responseBody);

      if (jsonResponse['success'] == true) {
        final List<dynamic> dataList = jsonResponse['data'] as List<dynamic>;

        final List<Map<String, dynamic>> listOfMaps = dataList
            .cast<Map<String, dynamic>>()
            .map((map) => map.map((key, value) => MapEntry(key, value ?? '')))
            .toList();

        return ApiResult.success(data: listOfMaps);
      } else {
        return ApiResult.failure(
          errorMessage: jsonResponse['message'] ?? 'Request failed',
        );
      }
    } catch (e) {
      dev.log('Error parsing JSON in GET: $e');
      return ApiResult.failure(errorMessage: 'Failed to parse response data');
    }
  }

  Future<ApiResult<dynamic>> post(String url, AbstractClass obj) async {
    return await _sendRequest(
      url,
      'POST',
      headers: {'Content-Type': 'application/json'},
      body: obj.toMap(),
    );
  }

  Future<ApiResult<dynamic>> put(String url, AbstractClass obj) async {
    return await _sendRequest(
      url,
      'PUT',
      headers: {'Content-Type': 'application/json'},
      body: obj.toMap(),
    );
  }

  Future<ApiResult<dynamic>> delete(String url) async {
    return await _sendRequest(
      url,
      'DELETE',
      headers: {'Accept': 'application/json; charset=utf-8'},
    );
  }

  Future<ApiResult<dynamic>> _sendRequest(
    String url,
    String method, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final client = http.Client();
    try {
      final request = http.Request(method, Uri.parse(url));
      if (headers != null) request.headers.addAll(headers);
      if (body != null) request.body = json.encode(body);

      try {
        await client.send(request).timeout(_connectionTimeout);
      } catch (e) {
        dev.log('Connection failed: $e');
        return ApiResult.failure(
            errorMessage:
                'Could not connect to server. Please check your connection.');
      }

      http.Response response;
      switch (method) {
        case 'GET':
          response = await client
              .get(Uri.parse(url), headers: headers)
              .timeout(_timeoutDuration);
          break;
        case 'POST':
          response = await client
              .post(Uri.parse(url), headers: headers, body: request.body)
              .timeout(_timeoutDuration);
          break;
        case 'PUT':
          response = await client
              .put(Uri.parse(url), headers: headers, body: request.body)
              .timeout(_timeoutDuration);
          break;
        case 'DELETE':
          response = await client
              .delete(Uri.parse(url), headers: headers)
              .timeout(_timeoutDuration);
          break;
        default:
          throw UnsupportedError('Unsupported HTTP method');
      }

      dev.log('Response status: ${response.statusCode}');
      dev.log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        return ApiResult.success(data: json.decode(response.body));
      } else {
        return ApiResult.failure(
            errorCode: response.statusCode.toString(),
            errorMessage: response.body);
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
    } finally {
      client.close();
    }
  }
}

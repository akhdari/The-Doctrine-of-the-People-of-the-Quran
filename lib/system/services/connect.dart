import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/models/post/abstract_class.dart';

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

  Map<String, String> get _jsonHeaders => {
        'Content-Type': 'application/json',
        'Accept': 'application/json; charset=utf-8',
      };

  Future<ApiResult<List<Map<String, dynamic>>>> get(String url) async {
    final client = http.Client();
    try {
      dev.log('Fetching data from: $url');

      await client
          .get(Uri.parse(url), headers: _jsonHeaders)
          .timeout(_connectionTimeout);

      final response = await client
          .get(Uri.parse(url), headers: _jsonHeaders)
          .timeout(_timeoutDuration);

      dev.log("Response status: ${response.statusCode}");
      dev.log("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final responseBody = utf8.decode(response.bodyBytes);
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
    } finally {
      client.close();
    }
  }

  Future<ApiResult<dynamic>> post(String url, AbstractClass obj) async {
    final client = http.Client();
    try {
      final requestBody = json.encode(obj.toMap());
      dev.log('Sending POST request to: $url');
      dev.log('Request body: $requestBody');

      final response = await client
          .post(
            Uri.parse(url),
            headers: _jsonHeaders,
            body: requestBody,
          )
          .timeout(_timeoutDuration);

      return _handleResponse(response);
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

  Future<ApiResult<dynamic>> delete(String url) async {
    final client = http.Client();
    try {
      dev.log('Sending DELETE request to: $url');

      final response = await client
          .delete(
            Uri.parse(url),
            headers: _jsonHeaders,
          )
          .timeout(_timeoutDuration);

      return _handleResponse(response);
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

  Future<ApiResult<dynamic>> put(String url, AbstractClass obj) async {
    final client = http.Client();
    try {
      final requestBody = json.encode(obj.toMap());
      dev.log('Sending PUT request to: $url');
      dev.log('Request body: $requestBody');

      final response = await client
          .put(
            Uri.parse(url),
            headers: _jsonHeaders,
            body: requestBody,
          )
          .timeout(_timeoutDuration);

      return _handleResponse(response);
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

  ApiResult<dynamic> _handleResponse(http.Response response) {
    dev.log('Response status: ${response.statusCode}');
    dev.log('Response body: ${response.body}');

    try {
      final decoded = json.decode(response.body);

      if (response.statusCode == 200) {
        return ApiResult.success(data: decoded);
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
      return ApiResult.failure(
        errorMessage: 'Invalid response format: ${e.message}',
      );
    }
  }
}

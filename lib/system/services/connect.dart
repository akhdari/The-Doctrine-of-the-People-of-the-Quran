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
  String? errorMessage;
  String? errorCode;
  List<Map<String, dynamic>> parseJsonList(http.Response response) {
    final List<dynamic> jsonResponse =
        json.decode(response.body) as List<dynamic>;
    final List<Map<String, dynamic>> listOfMaps = jsonResponse
        .cast<Map<String, dynamic>>()
        .map((map) => map.map(
            (key, value) => MapEntry(key, value ?? ''))) // Replace null with ''
        .toList();
    return listOfMaps;
  }

  Future<ApiResult<List<Map<String, dynamic>>>> get(String url) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Accept': 'application/json'},
      ).timeout(const Duration(seconds: 10));
      dev.log("response: ${response.body}");
      if (response.statusCode == 200) {
        return ApiResult.seccess(data: parseJsonList(response));
      } else {
        return ApiResult.failure(
          errorCode: response.statusCode.toString(),
          errorMessage: response.body,
        );
      }
    } on FormatException catch (e) {
      return ApiResult.failure(errorMessage: e.message);
    } on http.ClientException catch (e) {
      return ApiResult.failure(errorMessage: e.message);
    } on TimeoutException catch (e) {
      return ApiResult.failure(errorMessage: e.message);
    } catch (e) {
      return ApiResult.failure(errorMessage: e.toString());
    }
  }

  Future<ApiResult<dynamic>> post(String url, AbstractClass obj) async {
    try {
      final requestBody = json.encode(obj.toMap());
      dev.log("Request Body: $requestBody");
      final response = await http
          .post(Uri.parse(url),
              headers: {'Content-Type': 'application/json'},
              body: json.encode(obj.toMap()))
          .timeout(const Duration(seconds: 10));
      dev.log("response: ${response.body}");
      if (response.statusCode == 200) {
        dev.log(jsonEncode(obj.toMap()));
        dev.log("you seccusfully added data to the backend");
        return ApiResult.seccess(data: json.decode(response.body));
      } else if (response.statusCode == 400) {
        dev.log("end point not found");

        return ApiResult.failure(
          errorCode: response.statusCode.toString(),
          errorMessage: response.body,
        );
      } else if (response.statusCode == 500) {
        dev.log("server error");
        return ApiResult.failure(
          errorCode: response.statusCode.toString(),
          errorMessage: response.body,
        );
      } else {
        return ApiResult.failure(
          errorCode: response.statusCode.toString(),
          errorMessage: response.body,
        );
      }
    } on FormatException catch (e) {
      dev.log("Invalid JSON format ${e.message}");
      return ApiResult.failure(errorMessage: e.message);
    } on http.ClientException catch (e) {
      dev.log("Network error: ${e.message}");
      return ApiResult.failure(errorMessage: e.message);
    } on TimeoutException catch (e) {
      dev.log("Timeout error: ${e.message}");
      dev.log(ApiResult.failure(errorMessage: e.message).toString());
      return ApiResult.failure(errorMessage: e.message);
    } catch (e) {
      dev.log("Unknown error: ${e.toString()}");
      return ApiResult.failure(errorMessage: e.toString());
    }
  }
}

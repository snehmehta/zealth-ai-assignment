import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:zealth/constant/appURL.dart';

class ApiBaseHelper {
  Dio dio = Dio();

  Future<dynamic> get(String endpoint) async {
    var responseJson;
    try {
      final response = await dio.get(AppURL.baseURL + endpoint);
      responseJson = _returnResponse(response);
    } catch (e) {
      print(e.toString());
    }
    return responseJson;
  }

  Future<dynamic> post(
    String endpoint, {
    dynamic data,
    Map<String, dynamic> header,
  }) async {
    var responseJson;

    dio.interceptors.add(
      InterceptorsWrapper(),
    );

    try {
      final response = await dio.post(AppURL.baseURL + endpoint, data: data);
      responseJson = _returnResponse(response);
    } catch (e) {
      responseJson = {"status": "failed"};
      print(e.toString());
    }
    return responseJson;
  }

  dynamic _returnResponse(Response response) {
    final JsonDecoder _decoder = new JsonDecoder();
    final dynamic jsonBody = response.data;
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      throw new Exception("statusCode: $statusCode");
    }

    if (jsonBody is String) {
      return _decoder.convert(jsonBody);
    } else {
      return jsonBody;
    }
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../constants/app_api.dart';
import '../utils/check_internet_connection.dart';
import 'storage_service.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();

  factory ApiService() => _instance;

  static const String _baseUrl = AppApi.server;
  String? _token;
  static const Duration _timeout = Duration(seconds: 30);

  final http.Client _client;

  ApiService._internal() : _client = http.Client() {
    _loadToken();
  }

  Future<void> _loadToken() async {
    _token = await StorageService().read(key: "token");
  }

  Map<String, String> _buildHeaders({bool isMultipart = false}) {
    final headers = <String, String>{};
    if (!isMultipart) {
      headers['Content-Type'] = 'application/json';
    }
    if (_token != null && _token!.isNotEmpty) {
      headers['Authorization'] = 'Bearer $_token';
    }
    return headers;
  }

  Future<dynamic> sendRequest({
    required String method,
    required String endpoint,
    dynamic data,
    Map<String, dynamic>? queryParams,
    Map<String, String>? fields,
    File? imageFile,
    String? imageFieldName,
    String? customBaseUrl,
    int retryCount = 3,
    Duration retryDelay = const Duration(seconds: 2),
  }) async {
    if (!await checkInternetConnection()) {
      return {"status": "offline", "message": "No internet connection"};
    }
    await _loadToken();

    int attempts = 0;

    while (attempts < retryCount) {
      try {
        attempts++;
        Uri uri = Uri.parse('${customBaseUrl ?? _baseUrl}/$endpoint');
        if (queryParams != null) {
          final params =
          queryParams.map((key, value) => MapEntry(key, value.toString()));
          uri = uri.replace(queryParameters: params);
        }

        http.Response response;

        if (imageFile != null && imageFieldName != null) {
          final request = http.MultipartRequest(method, uri);
          if (fields != null) request.fields.addAll(fields);
          request.files.add(await http.MultipartFile.fromPath(
              imageFieldName, imageFile.path));
          request.headers.addAll(_buildHeaders(isMultipart: true));
          final streamedResponse = await request.send().timeout(_timeout);
          response = await http.Response.fromStream(streamedResponse);
        } else {
          final headers = _buildHeaders();
          switch (method.toUpperCase()) {
            case 'GET':
              response =
              await _client.get(uri, headers: headers).timeout(_timeout);
              break;
            case 'POST':
              response = await _client
                  .post(uri, body: jsonEncode(data), headers: headers)
                  .timeout(_timeout);
              break;
            case 'PUT':
              response = await _client
                  .put(uri, body: jsonEncode(data), headers: headers)
                  .timeout(_timeout);
              break;
            case 'DELETE':
              response =
              await _client.delete(uri, headers: headers).timeout(_timeout);
              break;
            default:
              throw Exception('Unsupported HTTP method: $method');
          }
        }

        return _handleResponse(response);
      } catch (e) {
        if (attempts >= retryCount) {
          return {
            "status": "failure",
            "message": "Request failed after $retryCount attempts",
            "error": e.toString(),
          };
        }
        // انتظر قبل إعادة المحاولة
        await Future.delayed(retryDelay);
      }
    }
    // لن يصل هنا عادة
    return {
      "status": "failure",
      "message": "Request failed after $retryCount attempts"
    };
  }


  Future<dynamic> get(String endpoint, {Map<String, dynamic>? queryParams}) =>
      sendRequest(method: 'GET', endpoint: endpoint, queryParams: queryParams);

  Future<dynamic> post(String endpoint, dynamic data) =>
      sendRequest(method: 'POST', endpoint: endpoint, data: data);

  Future<dynamic> put(String endpoint, dynamic data,
          {Map<String, dynamic>? queryParams}) =>
      sendRequest(
          method: 'PUT',
          endpoint: endpoint,
          data: data,
          queryParams: queryParams);

  Future<dynamic> delete(String endpoint,
          {Map<String, dynamic>? queryParams}) =>
      sendRequest(
          method: 'DELETE', endpoint: endpoint, queryParams: queryParams);

  Future<dynamic> postWithImage(
    String endpoint,
    String imageFieldName,
    File imageFile, {
    Map<String, String>? fields,
    String? customBaseUrl,
  }) =>
      sendRequest(
        method: 'POST',
        endpoint: endpoint,
        imageFieldName: imageFieldName,
        imageFile: imageFile,
        fields: fields,
        customBaseUrl: customBaseUrl,
      );

  dynamic _handleResponse(http.Response response) {
    print(response.body);
    try {
      return jsonDecode(response.body);
    } catch (e) {
      rethrow;
    }
  }
}

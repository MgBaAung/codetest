import 'dart:convert';

import 'package:b2b_freshmore/base_architecture/data/network_datasource/network_client.dart';
import 'package:http/http.dart' as http;

class FakeNetworkClient implements NetworkClient {
  FakeNetworkClient({http.Response? response})
    : response = response ?? http.Response('{}', 200);

  http.Response response;
  Uri? lastUri;
  String? lastMethod;
  Object? lastBody;
  bool disposed = false;

  @override
  Future<http.Response> get(Uri uri, {Map<String, String>? headers}) async {
    lastUri = uri;
    lastMethod = 'GET';
    return response;
  }

  @override
  Future<http.Response> post(
    Uri uri, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    lastUri = uri;
    lastMethod = 'POST';
    lastBody = body;
    return response;
  }

  @override
  Future<http.Response> put(
    Uri uri, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    lastUri = uri;
    lastMethod = 'PUT';
    lastBody = body;
    return response;
  }

  @override
  Future<http.Response> delete(
    Uri uri, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    lastUri = uri;
    lastMethod = 'DELETE';
    return response;
  }

  @override
  Future<http.Response> postMultipart(
    Uri uri,
    List<http.MultipartFile> files,
    Map<String, String> field,
  ) async {
    lastUri = uri;
    lastMethod = 'POST MULTIPART';
    return response;
  }

  @override
  Future<http.Response> putMultipart(
    Uri uri,
    List<http.MultipartFile> files,
    Map<String, String> field,
  ) async {
    lastUri = uri;
    lastMethod = 'PUT MULTIPART';
    return response;
  }

  @override
  void dispose() => disposed = true;
}

http.Response jsonResponse(Map<String, dynamic> body, {int statusCode = 200}) =>
    http.Response(jsonEncode(body), statusCode);

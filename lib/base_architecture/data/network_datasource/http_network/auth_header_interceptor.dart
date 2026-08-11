import 'dart:async';

import 'package:http/http.dart';
import 'package:http_interceptor/models/interceptor_contract.dart';

import '../../../../injection_container.dart';
import '../../../../presentation/global/key_util.dart';
import '../../../core/api_end_point.dart';
import '../../local_datasource/token_manager.dart';

class AuthHeaderInterceptor implements InterceptorContract {
  AuthHeaderInterceptor();

  @override
  FutureOr<BaseRequest> interceptRequest({required BaseRequest request}) async {
    final tokenManager = getIt<TokenManager>();
    String? token = await tokenManager.getToken(kAccess);

    String fullUrlString = request.url.toString();

    if (fullUrlString.contains(categoryUrl) ||
        fullUrlString.contains(subCategoryUrl) ||
        fullUrlString.contains(cartUrl) ||
        fullUrlString.contains(paymentTypeUrl) ||
        fullUrlString.contains(orderUrl)) {
      fullUrlString = fullUrlString.replaceFirst(baseUrl, inventApi);
    } else if (fullUrlString.contains(currencyUrl)) {
      fullUrlString = fullUrlString.replaceFirst(baseUrl, mainUrl);
    }

    Uri finalUri = Uri.parse(fullUrlString);

    bool isGeocoding = fullUrlString.contains('open-meteo.com');
    String urlPath = finalUri.path;
    bool isAuthRoute =
        urlPath.contains(loginUrl) || urlPath.contains(refreshUrl);

    if (request is! MultipartRequest) {
      request.headers['content-type'] = 'application/json';
    }

    if (token != null && token.isNotEmpty && !isAuthRoute && !isGeocoding) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    if (request is MultipartRequest) {
      return MultipartRequest(request.method, finalUri)
        ..headers.addAll(request.headers)
        ..fields.addAll(request.fields)
        ..files.addAll(request.files);
    } else if (request is Request) {
      return Request(request.method, finalUri)
        ..headers.addAll(request.headers)
        ..bodyBytes = request.bodyBytes;
    }

    return request;
  }

  @override
  FutureOr<BaseResponse> interceptResponse({required BaseResponse response}) =>
      response;

  @override
  FutureOr<bool> shouldInterceptRequest() => true;

  @override
  FutureOr<bool> shouldInterceptResponse() => true;
}

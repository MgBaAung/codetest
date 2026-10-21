import 'package:b2b_freshmore/base_architecture/domain/model/category_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/repository/api_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import '../../support/fake_network_client.dart';

void main() {
  group('ApiRepository', () {
    test('builds the request URI and maps a successful response', () async {
      final client = FakeNetworkClient(
        response: jsonResponse({'success': true, 'data': 'loaded'}),
      );
      final repository = ApiRepository<CategoryData>(
        networkClient: client,
        baseUrl: 'https://api.example.test',
      );

      final response = await repository.get<String>(
        '/categories',
        (json) => json['data'] as String,
        queryParams: {'page': 2, 'active': true},
      );

      expect(client.lastMethod, 'GET');
      expect(
        client.lastUri?.toString(),
        'https://api.example.test/categories?page=2&active=true',
      );
      expect(response.success, isTrue);
      expect(response.data, 'loaded');
    });

    test('converts a not-found response to a failure result', () {
      final repository = ApiRepository<CategoryData>(
        networkClient: FakeNetworkClient(),
        baseUrl: 'https://api.example.test',
      );

      final response = repository.handleResponse<String>(
        jsonResponse({}, statusCode: 404),
        (json) => 'unused',
      );

      expect(response.success, isFalse);
      expect(response.statusCode, 404);
      expect(response.message, 'Requested resource not found.');
    });

    test(
      'returns a parsing error when a successful response is invalid JSON',
      () {
        final repository = ApiRepository<CategoryData>(
          networkClient: FakeNetworkClient(),
          baseUrl: 'https://api.example.test',
        );

        final response = repository.handleResponse<String>(
          http.Response('not-json', 200),
          (json) => 'unused',
        );

        expect(response.success, isFalse);
        expect(response.statusCode, 200);
        expect(response.message, startsWith('Data format error:'));
      },
    );
  });
}

import 'package:b2b_freshmore/base_architecture/domain/model/category_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/repository/api_repository.dart';
import 'package:b2b_freshmore/base_architecture/domain/usecase/baste_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fake_network_client.dart';

void main() {
  group('CrudUseCase', () {
    test(
      'get delegates endpoint, query, and parser to its repository',
      () async {
        final client = FakeNetworkClient(
          response: jsonResponse({
            'data': {'id': 12, 'enName': 'Vegetables'},
          }),
        );
        final useCase = CrudUseCase<CategoryData>(
          repository: ApiRepository<CategoryData>(
            networkClient: client,
            baseUrl: 'https://api.example.test',
          ),
        );

        final result = await useCase.get(
          endpoint: '/categories/12',
          parser: (json) => CategoryData().fromMap(json['data']),
          isList: false,
          queryParams: {'include': 'products'},
        );

        expect(client.lastUri?.path, '/categories/12');
        expect(client.lastUri?.queryParameters, {'include': 'products'});
        expect(result.success, isTrue);
        expect(result.data?.id, 12);
        expect(result.data?.enName, 'Vegetables');
      },
    );

    test('getList parses response items into domain models', () async {
      final client = FakeNetworkClient(
        response: jsonResponse({
          'data': [
            {'id': 1, 'enName': 'Fruit'},
            {'id': 2, 'enName': 'Vegetables'},
          ],
        }),
      );
      final useCase = CrudUseCase<CategoryData>(
        repository: ApiRepository<CategoryData>(
          networkClient: client,
          baseUrl: 'https://api.example.test',
        ),
      );

      final result = await useCase.getList<CategoryData>(
        endpoint: '/categories',
        parser: (json) => (json['data'] as List)
            .map((item) => CategoryData().fromMap(item))
            .toList(),
      );

      expect(result.success, isTrue);
      expect(result.data?.map((item) => item.enName), ['Fruit', 'Vegetables']);
    });
  });
}

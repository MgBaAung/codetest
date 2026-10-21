import 'package:b2b_freshmore/base_architecture/core/api_response.dart';
import 'package:b2b_freshmore/base_architecture/core/master_object.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/category_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Core API response mapping', () {
    test('maps response metadata and a typed payload', () {
      final response = ApiResponse<int>.fromJson({
        'success': true,
        'message': 'Loaded',
        'statusCode': 200,
        'data': 42,
      }, (data) => data as int);

      expect(response.success, isTrue);
      expect(response.message, 'Loaded');
      expect(response.statusCode, 200);
      expect(response.data, 42);
    });

    test('maps list payload items through the supplied parser', () {
      final response = ApiResponse<dynamic>.fromListJson({
        'success': true,
        'statusCode': 200,
        'data': [1, 2, 3],
      }, (data) => data as int);

      expect(response.data, [1, 2, 3]);
    });

    test('leaves a missing payload null', () {
      final response = ApiResponse<String>.fromJson({
        'success': false,
        'message': 'Unavailable',
      }, (data) => data as String);

      expect(response.success, isFalse);
      expect(response.data, isNull);
    });
  });

  group('Domain model mapping', () {
    test('category response maps metadata and nested category data', () {
      final category = CategoryModel().fromMap({
        'statusCode': 200,
        'message': 'Categories loaded',
        'data': [
          {
            'id': 7,
            'enName': 'Fruit',
            'enDescription': 'Fresh fruit',
            'enRemark': 'Seasonal',
            'imageUrl': 'https://example.test/fruit.png',
            'status': true,
          },
        ],
      });

      expect(category, isA<MasterObject<CategoryModel>>());
      expect(category.statusCode, 200);
      expect(category.message, 'Categories loaded');
      expect(category.datas, hasLength(1));
      expect(category.datas!.single.id, 7);
      expect(category.datas!.single.enName, 'Fruit');
      expect(category.datas!.single.status, isTrue);
    });

    test('category response with null data becomes an empty collection', () {
      final category = CategoryModel().fromMap({
        'statusCode': 200,
        'message': 'No categories',
        'data': null,
      });

      expect(category.datas, isEmpty);
    });
  });
}

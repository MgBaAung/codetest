import 'package:b2b_freshmore/base_architecture/core/api_response.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/category_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/repository/api_repository.dart';
import 'package:b2b_freshmore/base_architecture/domain/usecase/baste_usecase.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_event.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_state.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/base_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fake_network_client.dart';

void main() {
  group('BaseBloc', () {
    test('emits loading then success for a successful fetch', () async {
      final bloc = BaseBloc<CategoryData>(
        crudUsecase: FakeCategoryUseCase(
          ApiResponse(
            success: true,
            data: CategoryData(id: 4, enName: 'Fruit'),
          ),
        ),
      );
      addTearDown(bloc.close);

      final expectation = expectLater(
        bloc.stream,
        emitsInOrder([
          const ApiLoading(),
          isA<ApiSuccess<CategoryData>>().having(
            (state) => state.data.enName,
            'category name',
            'Fruit',
          ),
        ]),
      );
      bloc.add(
        FetchDataEvent<CategoryData>(
          endpoint: '/categories/4',
          parser: (json) => CategoryData().fromMap(json),
        ),
      );

      await expectation;
    });

    test(
      'emits a failure state when the use case returns a failed response',
      () async {
        final bloc = BaseBloc<CategoryData>(
          crudUsecase: FakeCategoryUseCase(
            const ApiResponse(
              success: false,
              message: 'Unavailable',
              statusCode: 503,
            ),
          ),
        );
        addTearDown(bloc.close);

        final expectation = expectLater(
          bloc.stream,
          emitsInOrder([
            const ApiLoading(),
            const ApiFailure('Unavailable', statusCode: 503, error: ''),
          ]),
        );
        bloc.add(
          FetchDataEvent<CategoryData>(
            endpoint: '/categories',
            parser: (json) => CategoryData().fromMap(json),
          ),
        );

        await expectation;
      },
    );
  });
}

class FakeCategoryUseCase extends CrudUseCase<CategoryData> {
  FakeCategoryUseCase(this.response)
    : super(
        repository: ApiRepository<CategoryData>(
          networkClient: FakeNetworkClient(),
          baseUrl: 'https://api.example.test',
        ),
      );

  final ApiResponse<CategoryData> response;

  @override
  Future<ApiResponse<CategoryData>> get({
    required String endpoint,
    required CategoryData Function(dynamic) parser,
    required bool isList,
    Map<String, dynamic>? queryParams,
  }) async => response;
}

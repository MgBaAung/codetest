import '../../core/api_response.dart';
import '../../core/base_entity.dart';
import '../../core/master_object.dart';
import '../../data/local_datasource/local_datasource.dart';
import 'api_repository.dart';

class ApiRepositoryWithLocalStorage<
  T extends MasterObject<T>,
  E extends BaseEntity<T, E>
>
    extends ApiRepository<T> {
  final LocalDataSource<T, E> localDataSource;

  ApiRepositoryWithLocalStorage({
    required super.networkClient,
    required this.localDataSource,
  });

  @override
  Future<ApiResponse<T>> get<T>(
    String endPoint,
    T Function(dynamic p1) parser, {
    Map<String, dynamic>? queryParams,
    bool isList = false,
  }) async {
    try {
      // use isList as (refresh key) in user profile page, because removing the local data when refreshing the profile data, so that the local data will be updated with the new data from the API.
      if (isList) {
        final apiResponse = await super.get(
          endPoint,
          queryParams: queryParams,
          parser,
        );
        if (apiResponse.success) {
          localDataSource.clear();
          final data = apiResponse.data as dynamic;
          await localDataSource.clear();
          await localDataSource.save(data);
        }
        return apiResponse;
      } else {
        final List<T> cachedData = await localDataSource.getAll() as List<T>;

        if (cachedData.isNotEmpty) {
          return ApiResponse(success: true, data: cachedData.first);
        } else {
          final apiResponse = await super.get(
            endPoint,
            queryParams: queryParams,
            parser,
          );
          if (apiResponse.success) {
            final data = apiResponse.data as dynamic;
            await localDataSource.clear();
            await localDataSource.save(data);
          }
          return apiResponse;
        }
      }
    } catch (e) {
      return ApiResponse(success: false, message: 'API failed and post');
    }
  }

  @override
  Future<ApiResponse<TResponse>> post<TRequest, TResponse>(
    String endpoint,
    TRequest? data,
    TResponse Function(dynamic p1) parser,
  ) async {
    final entity = data as T;

    try {
      final apiResponse = await super.post(endpoint, data, parser);
      if (apiResponse.success && apiResponse.data != null) {
        try {
          await localDataSource.clear();
          await localDataSource.save(entity);
          return ApiResponse(success: true, data: entity as TResponse);
        } catch (e) {
          return ApiResponse(success: false, message: 'API failed and post');
        }
      } else {
        return ApiResponse(success: false, message: apiResponse.message);
      }
    } catch (e) {
      return ApiResponse(success: false, message: 'API failed and post');
    }
  }

  @override
  Future<ApiResponse<TResponse>> put<TRequest, TResponse>(
    String endpoint,
    String id,
    TRequest data,
    TResponse Function(dynamic p1) parser,
  ) async {
    final entity = data as T;

    try {
      await localDataSource.clear();
      await localDataSource.save(entity);
      return ApiResponse(success: true, data: entity as TResponse);
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'API failed and cache update failed. Cache error: $e',
      );
    }
  }

  @override
  Future<ApiResponse<T>> delete(
    String endpoint,
    String id,
    T Function(dynamic p1) parser,
  ) async {
    try {
      await localDataSource.delete(id);
      final apiResponse = await super.delete(endpoint, id, parser);
      if (apiResponse.success && apiResponse.data != null) {
        await localDataSource.delete(id);
        return apiResponse;
      } else {
        await localDataSource.delete(id);
        return ApiResponse(success: true, message: "delete sucessfully");
      }
    } catch (e) {
      try {
        await localDataSource.delete(id);
        return ApiResponse(success: true);
      } catch (cacheError) {
        return ApiResponse(
          success: false,
          message:
              'API failed and cache delete failed. Error: $e, Cache error: $cacheError',
        );
      }
    }
  }
}

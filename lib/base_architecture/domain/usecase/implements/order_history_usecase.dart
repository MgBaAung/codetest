import 'package:b2b_freshmore/base_architecture/core/api_response.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/order_history_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/user_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/usecase/baste_usecase.dart';
import 'package:b2b_freshmore/base_architecture/domain/usecase/implements/auth_usecase.dart';
import 'package:b2b_freshmore/injection_container.dart' as ic;

class OrderHistoryUsecase extends CrudUseCase<OrderHistoryModel> {
  OrderHistoryUsecase({required super.repository});

  var auth = ic.getIt.call<AuthUsecase>();

  @override
  Future<ApiResponse<List<T>>> getList<T>({
    required String endpoint,
    required List<T> Function(dynamic) parser,
    Map<String, dynamic>? queryParams,
    bool isList = false,
  }) async {
    try {
      var authResponse = await auth.get(
        endpoint: "/",
        parser: (json) => UserModel().fromMap(json),
        isList: false,
      );
      if (authResponse.success) {
        queryParams!["orgCode"] = authResponse.data?.code ?? "";
        return super.getList(
          endpoint: endpoint,
          parser: parser,
          queryParams: queryParams,
          isList: isList,
        );
      }
    } catch (e) {
      return ApiResponse(success: false);
    }

    return ApiResponse(success: false);
  }
}

import 'package:b2b_freshmore/base_architecture/core/api_response.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/currency_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/user_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/repository/implements/auth_repo.dart';
import 'package:b2b_freshmore/base_architecture/domain/usecase/baste_usecase.dart';
import 'package:b2b_freshmore/injection_container.dart' as ic;

class CurrencyUsecase extends CrudUseCase<CurrencyModel> {
  CurrencyUsecase({required super.repository});

  var auth = ic.getIt.call<AuthsRepository>();

  @override
  Future<ApiResponse<CurrencyModel>> get({
    required String endpoint,
    required CurrencyModel Function(dynamic) parser,
    required bool isList,
    Map<String, dynamic>? queryParams,
  }) async {
    int? locationId;
    ApiResponse<CurrencyModel> response;
    try {
      var user = await auth.get("/", (json) => UserModel().fromMap(json));
      if (user.success) {
        locationId = user.data?.locationId?.toInt();
        response = await super.get(
          endpoint: endpoint,
          parser: (json) => CurrencyModel().fromMap(json),
          isList: false,
        );
        if (response.success) {
          for (DataModel item in response.data?.data ?? []) {
            if (item.id == locationId) {
              var model = CurrencyModel(data: [item]);
              model.currency = item.currency;
              model.standardDisplayCode = item.standardDisplayCode;
              return ApiResponse(success: true, data: model);
            }
          }
        } else {
          return ApiResponse(success: false);
        }
      }
    } catch (e) {
      return ApiResponse(success: false);
    }
    return ApiResponse(success: false);
  }
}

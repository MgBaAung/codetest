import 'package:b2b_freshmore/base_architecture/core/api_end_point.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/currency_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/usecase/implements/currency_usecase.dart';
import 'package:b2b_freshmore/injection_container.dart' as ic;

import '../../../../injection_container.dart';
import '../../../../presentation/global/key_util.dart';
import '../../../core/api_response.dart';
import '../../../data/local_datasource/token_manager.dart';
import '../../model/user_model.dart';
import '../../repository/implements/auth_repo.dart';
import '../baste_usecase.dart';

class AuthUsecase extends CrudUseCase<UserModel> {
  AuthUsecase({required super.repository});

  var currency = ic.getIt.call<CurrencyUsecase>();


  @override
  Future<ApiResponse<UserModel>> update({
    required String endpoint,
    required String id,
    required UserModel data,
    required UserModel Function(dynamic) parser,
  }) async {
    var response = await super.update(
      endpoint: endpoint,
      id: id,
      data: data,
      parser: parser,
    );
    if (response.success) {
      var userinfo = getIt.call<AuthsRepository>();
      await userinfo.post(endpoint, response.data, parser);
    }
    return response;
  }

  @override
  Future<ApiResponse<UserModel>> create({
    required String endpoint,
    required UserModel? data,
    required UserModel Function(dynamic) parser,
  }) async {
    var response = await super.create(
      endpoint: endpoint,
      data: data,
      parser: parser,
    );

    if (response.success) {
      currency.get(
        endpoint: currencyUrl,
        parser: (json) => CurrencyModel().fromMap(json),
        isList: false,
        queryParams: {"locationid": response.data?.locationId ?? 0},
      );
      final tokenManager = getIt.call<TokenManager>();
      tokenManager.saveToken(kAccess, response.data?.accessToken ?? "");
      tokenManager.saveToken(kRefresh, response.data?.refreshToken ?? "");
    }
    return response;
  }
}

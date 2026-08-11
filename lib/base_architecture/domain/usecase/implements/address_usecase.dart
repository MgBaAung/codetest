import 'package:b2b_freshmore/base_architecture/core/api_response.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/address_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/user_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/usecase/baste_usecase.dart';
import 'package:b2b_freshmore/base_architecture/domain/usecase/implements/auth_usecase.dart';
import 'package:b2b_freshmore/injection_container.dart' as ic;

class AddressUsecase extends CrudUseCase<AddressModel> {
  var auth = ic.getIt.call<AuthUsecase>();
  AddressUsecase({required super.repository});

  @override
  Future<ApiResponse<AddressModel>> get({
    required String endpoint,
    required AddressModel Function(dynamic) parser,
    required bool isList,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      var authRespo = await auth.get(
        endpoint: "",
        parser: (json) => UserModel().fromMap(json),
        isList: false,
      );

      if (authRespo.success) {
        return super.get(
          endpoint: endpoint,
          parser: parser,
          isList: isList,
          queryParams: {"organizationId": authRespo.data?.organizationId},
        );
      } else {
        return ApiResponse(success: false);
      }
    } catch (e) {
      return ApiResponse(success: false);
    }
  }
}

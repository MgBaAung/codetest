import 'dart:io';
import 'package:b2b_freshmore/base_architecture/core/api_response.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/currency_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/topup_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/usecase/baste_usecase.dart';
import 'package:b2b_freshmore/base_architecture/domain/usecase/implements/currency_usecase.dart';
import 'package:b2b_freshmore/injection_container.dart' as ic;

class WalletRequestUsecase extends CrudUseCase<TopupModel> {
  WalletRequestUsecase({required super.repository});

  var currency = ic.getIt.call<CurrencyUsecase>();

  @override
  Future<ApiResponse<TopupModel>> uploade({
    required String endpoint,
    required Map<String, dynamic> fields,
    required File file,
    required String fieldName,
    required TopupModel Function(dynamic) parser,
  }) async {
    try {
      var currencyResponse = await currency.get(
        endpoint: "/",
        parser: (json) => CurrencyModel().fromMap(json),
        isList: false,
      );

      if (currencyResponse.success) {
        fields['currency'] = currencyResponse.data?.currency;
        return super.uploade(
          endpoint: endpoint,
          fields: fields,
          file: file,
          fieldName: fieldName,
          parser: parser,
        );
      }
      return ApiResponse(success: false);
    } catch (e) {
      return ApiResponse(success: false);
    }
  }
}

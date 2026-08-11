import 'package:b2b_freshmore/base_architecture/core/api_response.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/currency_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/order_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/usecase/baste_usecase.dart';
import 'package:b2b_freshmore/base_architecture/domain/usecase/implements/currency_usecase.dart';
import 'package:b2b_freshmore/injection_container.dart' as ic;

class OrderUsecase extends CrudUseCase<OrderModel> {
  OrderUsecase({required super.repository});

  var currencyUsecase = ic.getIt<CurrencyUsecase>();

  @override
  Future<ApiResponse<OrderModel>> create({
    required String endpoint,
    required OrderModel? data,
    required OrderModel Function(dynamic) parser,
  }) async {
    try {
      var currencyResponse = await currencyUsecase.get(
        endpoint: "/",
        parser: (json) => CurrencyModel().fromMap(json),
        isList: false,
      );

      if (currencyResponse.success) {
        data?.standardDisplayCode = currencyResponse.data?.standardDisplayCode;
        data?.currency = currencyResponse.data?.currency;
        return super.create(endpoint: endpoint, data: data, parser: parser);
      }
    } catch (e) {
      return ApiResponse(success: false);
    }
    return ApiResponse(success: false);
  }
}

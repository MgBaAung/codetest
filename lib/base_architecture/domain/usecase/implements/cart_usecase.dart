import 'package:b2b_freshmore/base_architecture/core/api_response.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/cart_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/currency_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/usecase/baste_usecase.dart';
import 'package:b2b_freshmore/base_architecture/domain/usecase/implements/currency_usecase.dart';
import 'package:b2b_freshmore/injection_container.dart' as ic;

class CartUsecase extends CrudUseCase<CartModel> {
  CartUsecase({required super.repository});

  var currencyUsecase = ic.getIt<CurrencyUsecase>();

  @override
  Future<ApiResponse<CartModel>> create({
    required String endpoint,
    required CartModel? data,
    required CartModel Function(dynamic) parser,
  }) async {
    await currencyUsecase
        .get(
          endpoint: "endpoint",
          parser: (json) => CurrencyModel().fromMap(json),
          isList: false,
        )
        .then((datas) {
          data?.currency = datas.data?.currency ?? "MMK";
        });

    return await super.create(endpoint: endpoint, data: data, parser: parser);
  }
}

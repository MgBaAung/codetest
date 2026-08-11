import 'package:b2b_freshmore/base_architecture/core/api_end_point.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/product_model.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_event.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/base_bloc.dart';

class ProductDetailBloc extends BaseBloc<ProductModel> {
  ProductDetailBloc({required super.crudUsecase});

  int? ids;

  void getProductDetail({int? id}) {
    ids = id ?? ids!;
    add(
      FetchDataEvent(
        endpoint: '$productUrl/$ids',
        parser: (json) => ProductModel().fromMap(json),
      ),
    );
  }
}

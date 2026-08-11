import 'package:b2b_freshmore/base_architecture/core/api_end_point.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/cart_model.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_event.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_state.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/base_bloc.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/product_model.dart'
    as p;
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends BaseBloc<CartModel> {
  CartBloc({required super.crudUsecase});

  void addToCart({p.ProductModel? model, required int quantity}) async {
    var cartModel = CartModel(
      productId: model?.productData?[0].id?.toInt(),
      quantity: quantity,
      price: model?.productData?[0].price?.toDouble(),
      subTotal: quantity * (model?.productData?[0].price ?? 0).toDouble(),
    );
    add(
      CreateDataEvent(
        endpoint: cartUrl,
        data: cartModel,
        parser: (json) => cartModel.fromMap(json),
      ),
    );
  }
}

class CartListBloc extends BaseBloc<CartModel> {
  CartListBloc({required super.crudUsecase});
  int count = 0;

  int cartCount() {
    if (state is ApiSuccess<CartModel>) {
      var cartList = (state as ApiSuccess<CartModel>).data.data ?? [];
      count = cartList.length;
    }
    return count;
  }

  void buildkartList(List<DataModel> cartList) {
    var model = CartModel(data: cartList);
    add(
      CreateDataEvent(
        endpoint: cartBulkUrl,
        data: model,
        parser: (json) => model.fromMap(json),
      ),
    );
  }

  void getCartList() {
    add(
      FetchDataEvent(
        endpoint: cartUrl,
        parser: (json) => CartModel().fromMap(json),
      ),
    );
  }

  void deleteCart({int? id}) {
    add(
      DeleteDataEvent(
        endpoint: cartUrl,
        id: id == null ? "" : id.toString(),
        parser: (json) => CartModel().fromMap(json),
      ),
    );
  }

  @override
  Future<void> onCreate(
    CreateDataEvent<CartModel, CartModel> event,
    Emitter<ApiState> emit,
  ) async {
    try {
      final response = await crudUsecase.create(
        endpoint: event.endpoint,
        data: event.data,
        parser: event.parser,
      );

      if (response.success && response.data != null) {
        emit(ApiSuccess<CartModel>(response.data!));
      } else {
        emit(
          ApiFailure(
            response.message ?? 'failed to fetch data',
            statusCode: response.statusCode,
            error: "",
          ),
        );
      }
    } catch (e) {
      emit(ApiFailure('Unexpected error: $e', error: e));
    }
  }

  @override
  Future<void> onDelete(
    DeleteDataEvent<CartModel> event,
    Emitter<ApiState> emit,
  ) async {
    if (event.id.isEmpty) {
      emit(const ApiLoading());
    } else {
      emit(const ApiNoState());
    }

    try {
      final response = await crudUsecase.delete(
        event.endpoint,
        event.id,
        event.parser,
      );

      if (response.success && response.data != null) {
        emit(ApiSuccess<CartModel>(response.data!));
      } else {
        emit(
          ApiFailure(
            response.message ?? 'Failed to delete by ${event.id}',
            statusCode: response.statusCode,
            error: "",
          ),
        );
      }
    } catch (e) {
      emit(ApiFailure('Unexpected error: $e', error: e));
    }
  }
}

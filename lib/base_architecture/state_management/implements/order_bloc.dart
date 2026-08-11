import 'package:b2b_freshmore/base_architecture/core/api_end_point.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/order_model.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_event.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/base_bloc.dart';

class OrderBloc extends BaseBloc<OrderModel> {
  OrderBloc({required super.crudUsecase});

  void createOrder(OrderModel model) {
    add(
      CreateDataEvent(
        endpoint: orderUrl,
        data: model,
        parser: (json) => model.fromMap(json),
      ),
    );
  }
}

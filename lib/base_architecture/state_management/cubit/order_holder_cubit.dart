
import 'package:b2b_freshmore/base_architecture/domain/model/order_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderHolderCubit extends Cubit<OrderModel> {
  OrderHolderCubit() : super(OrderModel());

  void setOrder(OrderModel order) {

    emit(order);
  }

  void clearOrder() {
    emit(OrderModel());
  }
}

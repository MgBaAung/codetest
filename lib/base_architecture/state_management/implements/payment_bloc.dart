import 'dart:core';

import 'package:b2b_freshmore/base_architecture/core/api_end_point.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/payment_model.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_event.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/base_bloc.dart';

class PaymentBloc extends BaseBloc<PaymentModel> {
  PaymentBloc({required super.crudUsecase});

  void getPaymentList() {
    add(
      FetchAllDataEvent(
        endpoint: paymentTypeUrl,
        isList: true,
        parser: (data) => (data['data'] as List<dynamic>)
            .map((e) => PaymentModel().fromMap(e as Map<String, dynamic>))
            .toList(),
      ),
    );
  }
}

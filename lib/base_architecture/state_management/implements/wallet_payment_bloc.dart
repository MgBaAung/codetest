import 'package:b2b_freshmore/base_architecture/core/api_end_point.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/wallet_payment_model.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_event.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/base_bloc.dart';

class WalletPaymentBloc extends BaseBloc<WalletPaymentModel> {
  WalletPaymentBloc({required super.crudUsecase});

  void getWalletPayment() {
    add(
      FetchDataEvent(
        endpoint: paymentWalletMethodUrl,
        parser: (json) => WalletPaymentModel().fromMap(json),
      ),
    );
  }
}

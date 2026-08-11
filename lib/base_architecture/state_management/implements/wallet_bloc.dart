import 'package:b2b_freshmore/base_architecture/core/api_end_point.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/wallet_model.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_event.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/base_bloc.dart';

class WalletBloc extends BaseBloc<WalletModel> {
  WalletBloc({required super.crudUsecase});

  void getWallets() {
    add(
      FetchDataEvent(
        endpoint: myWalletUrl,
        parser: (json) => WalletModel(id: 0).fromMap(json),
      ),
    );
  }
}

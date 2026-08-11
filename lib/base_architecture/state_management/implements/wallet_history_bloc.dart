import 'package:b2b_freshmore/base_architecture/core/api_end_point.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/wallet_history_model.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_event.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/base_bloc.dart';

class WalletHistoryBloc extends BaseBloc<WalletHistoryDataModel> {
  WalletHistoryBloc({required super.crudUsecase});

  int page = 1;

  void getList({bool shouldAppend = false, bool refresh = false}) {
    if (shouldAppend) {
      page++;
    } else {
      page = 1;
    }

    Map<String, dynamic> map = {};

    map["page"] = page;
    map["limit"] = 20;

    add(
      FetchAllDataEvent<WalletHistoryDataModel>(
        endpoint: walletHistoryUrl,
        queryParams: map,
        shouldAppend: shouldAppend,
        isList: true,
        parser: (json) {
          final List<dynamic> dataList = json['data'] as List<dynamic>;
          return dataList
              .map((e) => WalletHistoryDataModel().fromMap(e))
              .toList();
        },
      ),
    );
  }

}

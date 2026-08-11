import 'package:b2b_freshmore/base_architecture/core/api_end_point.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/amount_model.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_event.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/base_bloc.dart';

class AmountBloc extends BaseBloc<AmountModel> {
  AmountBloc({required super.crudUsecase});

  void getAmountList() {
    add(
      FetchDataEvent(
        endpoint: amountUrl,
        parser: (json) => AmountModel(id: 0).fromMap(json),
      ),
    );
  }
}

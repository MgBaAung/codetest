import 'package:b2b_freshmore/base_architecture/core/api_end_point.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/topup_model.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_event.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/base_bloc.dart';

class WalletRequestBloc extends BaseBloc<TopupModel> {
  WalletRequestBloc({required super.crudUsecase});

  void uploadRequest({required TopupModel model}) {
    add(
      UploadeFileEvent(
        endpoint: topUpRequestUrl,
        data: model.toMap(model),
        file: model.attachment!,
        fieldName: "attachment",
        parser: (json) => TopupModel(id: 0).fromMap(json),
      ),
    );
  }
}

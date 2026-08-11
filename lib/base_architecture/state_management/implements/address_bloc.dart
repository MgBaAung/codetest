import 'package:b2b_freshmore/base_architecture/core/api_end_point.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/address_model.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_event.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/base_bloc.dart';

class AddressBloc extends BaseBloc<AddressModel> {
  AddressBloc({required super.crudUsecase});

  void getAddressList() {
    add(
      FetchDataEvent(
        endpoint: addressUrl,
        parser: (data) => AddressModel().fromMap(data),
      ),
    );
  }
}

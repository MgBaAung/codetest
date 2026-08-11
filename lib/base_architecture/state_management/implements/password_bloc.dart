import 'package:b2b_freshmore/base_architecture/core/api_end_point.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/password_model.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_event.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/base_bloc.dart';

class PasswordBloc extends BaseBloc<PasswordModel> {
  PasswordBloc({required super.crudUsecase});

  void change({required String news, required String old}) {
    var data = PasswordModel(oldPassword: old, newPassword: news);
    add(
      CreateDataEvent(
        endpoint: passwordUrl,
        data: data,
        parser: (json) => PasswordModel().fromMap(json),
      ),
    );
  }
}

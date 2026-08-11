import 'package:b2b_freshmore/base_architecture/core/api_end_point.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/forget_pwd_model.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_event.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/base_bloc.dart';

class ForgetPwdBloc extends BaseBloc<ForgetPwdModel> {
  ForgetPwdBloc({required super.crudUsecase});

  void forget({required String id, required String level}) {
    var data = ForgetPwdModel(level: level, orgCode: id);

    add(
      CreateDataEvent(
        endpoint: forgetPswdUrl,
        data: data,
        parser: (json) => data.fromMap(json),
      ),
    );
  }
}

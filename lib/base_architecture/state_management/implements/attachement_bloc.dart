import 'package:b2b_freshmore/base_architecture/core/api_end_point.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/attachement_model.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_event.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/base_bloc.dart';

class AttachementBloc extends BaseBloc<AttachementModel> {
  AttachementBloc({required super.crudUsecase});

  void uploadAttachement(AttachementModel model) {
    add(
      PutFileEvent(
        endpoint: '$orderUrl/${model.id}$attachementUrl',
        data: <String, dynamic>{},
        parser: (json) => AttachementModel().fromMap(json),
        fieldName: 'paymentAttachment',
        file: model.file!,
      ),
    );
  }
}

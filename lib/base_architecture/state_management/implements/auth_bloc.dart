import '../../core/api_end_point.dart';
import '../../domain/model/user_model.dart';
import '../bloc/api_event.dart';
import '../bloc/base_bloc.dart';

class AuthBloc extends BaseBloc<UserModel> {
  AuthBloc({required super.crudUsecase});

  void clear() {
    add(
      DeleteDataEvent(
        endpoint: "",
        id: "0",
        parser: (json) => UserModel().fromMap(json),
      ),
    );
  }

  void getInfo() {
    add(
      FetchDataEvent(
        endpoint: "endpoint",
        parser: (json) => UserModel().fromMap(json),
      ),
    );
  }

  void login({
    required String id,
    required String password,
    required String code,
  }) {
    UserModel user = UserModel(password: password, ownerId: id, code: code);
    add(
      CreateDataEvent(
        endpoint: loginUrl,
        data: user,
        parser: (json) => user.fromMap(json),
      ),
    );
  }

  void getProfile() {
    add(
      FetchDataEvent(
        isList: true,
        endpoint: profileUrl,
        parser: (json) => UserModel().fromMap(json),
      ),
    );
  }
}

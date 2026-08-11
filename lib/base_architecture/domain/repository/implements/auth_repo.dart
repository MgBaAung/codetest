import '../../entity/user_entity.dart';
import '../../model/user_model.dart';
import '../api_repository_with_local.dart';

class AuthsRepository
    extends ApiRepositoryWithLocalStorage<UserModel, UserEntity> {
  AuthsRepository({
    required super.networkClient,
    required super.localDataSource,
  });
}

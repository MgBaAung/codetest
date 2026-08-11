import 'package:b2b_freshmore/base_architecture/domain/entity/currency_entity.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/currency_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/repository/api_repository_with_local.dart';

class CurrencyRepo
    extends ApiRepositoryWithLocalStorage<CurrencyModel, CurrencyEntity> {
  CurrencyRepo({required super.networkClient, required super.localDataSource});
}

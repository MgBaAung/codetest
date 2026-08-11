import 'package:b2b_freshmore/base_architecture/data/local_datasource/hive_local_datasource.dart';
import 'package:b2b_freshmore/base_architecture/data/local_datasource/local_datasource.dart';
import 'package:b2b_freshmore/base_architecture/data/local_datasource/token_manager.dart';
import 'package:b2b_freshmore/base_architecture/data/network_datasource/http_network/http_network.dart';
import 'package:b2b_freshmore/base_architecture/data/network_datasource/network_client.dart';
import 'package:b2b_freshmore/base_architecture/domain/entity/currency_entity.dart';
import 'package:b2b_freshmore/base_architecture/domain/entity/user_entity.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/address_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/amount_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/attachement_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/book_mark_model.dart'
    as bm;
import 'package:b2b_freshmore/base_architecture/domain/model/cart_model.dart'
    as cart;
import 'package:b2b_freshmore/base_architecture/domain/model/category_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/currency_model.dart'
    hide DataModel;
import 'package:b2b_freshmore/base_architecture/domain/model/forget_pwd_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/level_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/order_history_model.dart'
    as oh;
import 'package:b2b_freshmore/base_architecture/domain/model/order_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/password_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/payment_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/product_model.dart'
    as p;
import 'package:b2b_freshmore/base_architecture/domain/model/sub_category.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/topup_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/user_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/wallet_history_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/wallet_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/wallet_payment_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/repository/api_repository.dart';
import 'package:b2b_freshmore/base_architecture/domain/repository/implements/auth_repo.dart';
import 'package:b2b_freshmore/base_architecture/domain/repository/implements/current_repo.dart';
import 'package:b2b_freshmore/base_architecture/domain/usecase/baste_usecase.dart';
import 'package:b2b_freshmore/base_architecture/domain/usecase/implements/address_usecase.dart';
import 'package:b2b_freshmore/base_architecture/domain/usecase/implements/auth_usecase.dart';
import 'package:b2b_freshmore/base_architecture/domain/usecase/implements/cart_usecase.dart';
import 'package:b2b_freshmore/base_architecture/domain/usecase/implements/currency_usecase.dart';
import 'package:b2b_freshmore/base_architecture/domain/usecase/implements/order_history_usecase.dart';
import 'package:b2b_freshmore/base_architecture/domain/usecase/implements/order_usecase.dart';
import 'package:b2b_freshmore/base_architecture/domain/usecase/implements/wallet_request_usecase.dart';
import 'package:b2b_freshmore/base_architecture/state_management/cubit/holder_cubilt.dart';
import 'package:b2b_freshmore/base_architecture/state_management/cubit/order_holder_cubit.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/address_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/amount_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/attachement_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/auth_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/book_mark_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/cart_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/category_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/currency_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/forget_pwd_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/level_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/order_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/order_history_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/password_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/payment_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/product_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/product_detail_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/sub_category_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/top_up_history_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/wallet_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/wallet_history_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/wallet_payment_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/wallet_request_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/product_model.dart'
    as ic;
import 'package:upgrader/upgrader.dart';

final getIt = GetIt.instance;
late final Box<UserEntity> userBox;
late final Box<CurrencyEntity> currencyuserBox;

Future<void> initGetIt() async {
  //upgrader
  await Upgrader.clearSavedSettings();

  //update business logic
  await Hive.initFlutter();
  UserEntity.register();
  CurrencyEntity.register();
  userBox = await Hive.openBox<UserEntity>('login');
  currencyuserBox = await Hive.openBox<CurrencyEntity>('currency');

  //// new bloc
  getIt.registerFactory(() => AttachementBloc(crudUsecase: getIt.call()));
  getIt.registerFactory(() => AuthBloc(crudUsecase: getIt.call<AuthUsecase>()));
  getIt.registerFactory(() => ProductBloc(crudUsecase: getIt.call()));
  getIt.registerLazySingleton<HolderCubit>(() => HolderCubit());
  getIt.registerLazySingleton(() => CategoryBloc(crudUsecase: getIt.call()));
  getIt.registerFactory(() => LevelBloc(crudUsecase: getIt.call()));
  getIt.registerFactory(() => ProductDetailBloc(crudUsecase: getIt.call()));
  getIt.registerLazySingleton(() => BookMarkBloc(crudUsecase: getIt.call()));
  getIt.registerFactory(() => PasswordBloc(crudUsecase: getIt.call()));
  getIt.registerFactory(() => CreateBookMarkBloc(crudUsecase: getIt.call()));
  getIt.registerFactory(() => SubCategoryBloc(crudUsecase: getIt.call()));
  getIt.registerFactory(() => ForgetPwdBloc(crudUsecase: getIt.call()));
  getIt.registerFactory(() => CartBloc(crudUsecase: getIt.call<CartUsecase>()));
  getIt.registerLazySingleton(() => CartListBloc(crudUsecase: getIt.call()));
  getIt.registerFactory(() => PaymentBloc(crudUsecase: getIt.call()));
  getIt.registerFactory(() => AddressBloc(crudUsecase: getIt.call<AddressUsecase>()));
  getIt.registerFactory(() => AmountBloc(crudUsecase: getIt.call()));
  getIt.registerFactory(() => OrderBloc(crudUsecase: getIt.call<OrderUsecase>()));
  getIt.registerFactory(() => CurrencyBloc(crudUsecase: getIt.call<CurrencyUsecase>()));
  getIt.registerLazySingleton(() => OrderHolderCubit());
  getIt.registerFactory(() => OrderHistoryBloc(crudUsecase: getIt.call<OrderHistoryUsecase>()));
  getIt.registerLazySingleton(() => WalletBloc(crudUsecase: getIt.call()));
  getIt.registerLazySingleton(() => WalletPaymentBloc(crudUsecase: getIt.call()));
  getIt.registerLazySingleton(() => WalletRequestBloc(crudUsecase: getIt.call<WalletRequestUsecase>()));
  getIt.registerLazySingleton(() => WalletHistoryBloc(crudUsecase: getIt.call()));
  getIt.registerLazySingleton(() => TopUpHistoryBloc(crudUsecase: getIt.call()));

  /// new usecase
  getIt.registerLazySingleton(() => AuthUsecase(repository: getIt.call<AuthsRepository>()));
  getIt.registerLazySingleton(() => CrudUseCase<AttachementModel>(repository: getIt.call()));
  getIt.registerLazySingleton(() => CrudUseCase<WalletHistoryDataModel>(repository: getIt.call()));
  getIt.registerLazySingleton(() => CrudUseCase<AmountModel>(repository: getIt.call()));
  getIt.registerLazySingleton(() => CrudUseCase<UserModel>(repository: getIt.call()));
  getIt.registerLazySingleton(() => OrderHistoryUsecase(repository: getIt.call()));
  getIt.registerLazySingleton(() => OrderUsecase(repository: getIt.call()));
  getIt.registerLazySingleton(() => CrudUseCase<PaymentModel>(repository: getIt.call()));
  getIt.registerLazySingleton(() => CrudUseCase<cart.CartModel>(repository: getIt.call()));
  getIt.registerLazySingleton(() => CrudUseCase<CategoryData>(repository: getIt.call()));
  getIt.registerLazySingleton(() => CrudUseCase<p.ProductModel>(repository: getIt.call()));
  getIt.registerLazySingleton(() => CrudUseCase<p.ProductData>(repository: getIt.call()));
  getIt.registerLazySingleton(() => CrudUseCase<bm.ProductData>(repository: getIt.call()));
  getIt.registerLazySingleton(() => CrudUseCase<bm.BookMarkModel>(repository: getIt.call()));
  getIt.registerLazySingleton(() => CrudUseCase<PasswordModel>(repository: getIt.call()));
  getIt.registerLazySingleton(() => CrudUseCase<LevelModel>(repository: getIt.call()));
  getIt.registerLazySingleton(() => AddressUsecase(repository: getIt.call()));
  getIt.registerLazySingleton(() => CrudUseCase<SubCategoryData>(repository: getIt.call()));
  getIt.registerLazySingleton(() => CrudUseCase<ForgetPwdModel>(repository: getIt.call()));
  getIt.registerLazySingleton(() => CartUsecase(repository: getIt.call()));
  getIt.registerLazySingleton(() => CurrencyUsecase(repository: getIt.call<CurrencyRepo>()));
  getIt.registerLazySingleton(() => CrudUseCase<WalletModel>(repository: getIt.call()));
  getIt.registerLazySingleton(() => CrudUseCase<WalletPaymentModel>(repository: getIt.call()));
  getIt.registerLazySingleton(() => WalletRequestUsecase(repository: getIt.call()));

  /// new repository
  getIt.registerLazySingleton(() => AuthsRepository(
      networkClient: getIt.call(),
      localDataSource: getIt.call(),
    ),
  );
  getIt.registerLazySingleton(() => CurrencyRepo(
      networkClient: getIt.call(),
      localDataSource: getIt.call<LocalDataSource<CurrencyModel, CurrencyEntity>>(),
    ),
  );
  getIt.registerLazySingleton(() => ApiRepository<WalletModel>(networkClient: getIt.call()));
  getIt.registerLazySingleton(() => ApiRepository<AttachementModel>(networkClient: getIt.call()));
  getIt.registerLazySingleton(() => ApiRepository<AmountModel>(networkClient: getIt.call()));
  getIt.registerLazySingleton(() => ApiRepository<WalletHistoryDataModel>(networkClient: getIt.call()));
  getIt.registerLazySingleton(() => ApiRepository<TopupModel>(networkClient: getIt.call()));
  getIt.registerLazySingleton(() => ApiRepository<PaymentModel>(networkClient: getIt.call()));
  getIt.registerLazySingleton(() => ApiRepository<OrderModel>(networkClient: getIt.call()));
  getIt.registerLazySingleton(() => ApiRepository<AddressModel>(networkClient: getIt.call()));
  getIt.registerLazySingleton(() => ApiRepository<ForgetPwdModel>(networkClient: getIt.call()));
  getIt.registerLazySingleton(() => ApiRepository<cart.CartModel>(networkClient: getIt.call()));
  getIt.registerLazySingleton(() => ApiRepository<p.ProductModel>(networkClient: getIt.call()));
  getIt.registerLazySingleton(() => ApiRepository<ic.ProductData>(networkClient: getIt.call()));
  getIt.registerLazySingleton(() => ApiRepository<CategoryData>(networkClient: getIt.call()));
  getIt.registerLazySingleton(() => ApiRepository<LevelModel>(networkClient: getIt.call()));
  getIt.registerLazySingleton(() => ApiRepository<bm.ProductData>(networkClient: getIt.call()));
  getIt.registerLazySingleton(() => ApiRepository<bm.BookMarkModel>(networkClient: getIt.call()));
  getIt.registerLazySingleton(() => ApiRepository<PasswordModel>(networkClient: getIt.call()));
  getIt.registerLazySingleton(() => ApiRepository<oh.OrderHistoryModel>(networkClient: getIt.call()));
  getIt.registerLazySingleton(() => ApiRepository<SubCategoryData>(networkClient: getIt.call()));
  getIt.registerLazySingleton(() => ApiRepository<CurrencyModel>(networkClient: getIt.call()));
  getIt.registerLazySingleton(() => ApiRepository<cart.DataModel>(networkClient: getIt.call()));
  getIt.registerLazySingleton(() => ApiRepository<WalletPaymentModel>(networkClient: getIt.call()));

  /// single http network client & datasource
  getIt.registerLazySingleton<NetworkClient>(() => HttpNetworkClient());

  getIt.registerLazySingleton<LocalDataSource<UserModel, UserEntity>>(
    () => HiveLocalDataSourceImpl<UserModel, UserEntity>(
      entityFactory: () => UserEntity(),
      box: userBox,
    ),
  );
  getIt.registerLazySingleton<LocalDataSource<CurrencyModel, CurrencyEntity>>(
    () => HiveLocalDataSourceImpl<CurrencyModel, CurrencyEntity>(
      entityFactory: () => CurrencyEntity(),
      box: currencyuserBox,
    ),
  );
  getIt.registerLazySingleton<TokenManager>(
    () => TokenManager(storage: getIt.call()),
  );
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => FlutterSecureStorage(
      aOptions: AndroidOptions(resetOnError: true),
      iOptions: IOSOptions(
        synchronizable: false,
        accessibility: KeychainAccessibility.first_unlock_this_device,
      ),
    ),
  );

  getIt.registerLazySingleton<CacheManager>(
    () => CacheManager(
      Config(
        'b2bFreshMoeCache',
        stalePeriod: const Duration(days: 7),
        maxNrOfCacheObjects: 350,
      ),
    ),
  );
}

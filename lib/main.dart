import 'package:b2b_freshmore/base_architecture/data/local_datasource/token_manager.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/bloc_observer.dart';
import 'package:b2b_freshmore/base_architecture/state_management/cubit/bottom_nav_cubit.dart';
import 'package:b2b_freshmore/base_architecture/state_management/cubit/order_holder_cubit.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/address_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/amount_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/auth_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/book_mark_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/cart_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/category_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/currency_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/level_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/order_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/order_history_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/payment_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/product_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/product_detail_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/sub_category_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/top_up_history_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/wallet_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/wallet_history_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/wallet_payment_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/wallet_request_bloc.dart';
import 'package:b2b_freshmore/injection_container.dart' as ic;
import 'package:b2b_freshmore/presentation/global/app_route_constant.dart';
import 'package:b2b_freshmore/presentation/global/app_theme.dart';
import 'package:b2b_freshmore/presentation/global/enumeration.dart';
import 'package:b2b_freshmore/presentation/global/navigation_service.dart';
import 'package:b2b_freshmore/splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upgrader/upgrader.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await ic.initGetIt();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(
      EasyLocalization(
        supportedLocales: LanguageEnum.values.map((e) => e.locale).toList(),
        fallbackLocale: LanguageEnum.english.locale,
        path: 'assets/translations',
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ic.getIt<TokenManager>(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => BottomNavCubit()),
          BlocProvider(create: (context) => ic.getIt<OrderHolderCubit>()),
          BlocProvider(create: (context) => ic.getIt<AuthBloc>()..getInfo()),
          BlocProvider(create: (context) => ic.getIt<LevelBloc>()),
          BlocProvider(
            create: (context) => ic.getIt<CategoryBloc>()..getCategoryList(),
          ),
          BlocProvider(create: (context) => ic.getIt.call<ProductBloc>()),
          BlocProvider(create: (context) => ic.getIt.call<ProductDetailBloc>()),
          BlocProvider(create: (context) => ic.getIt.call<BookMarkBloc>()),
          BlocProvider(
            create: (context) => ic.getIt.call<CreateBookMarkBloc>(),
          ),
          BlocProvider(create: (context) => ic.getIt.call<SubCategoryBloc>()),
          BlocProvider(create: (context) => ic.getIt.call<CartBloc>()),
          BlocProvider(create: (context) => ic.getIt.call<CurrencyBloc>()),
          BlocProvider(create: (context) => ic.getIt.call<CartListBloc>()),
          BlocProvider(create: (context) => ic.getIt.call<PaymentBloc>()),
          BlocProvider(create: (context) => ic.getIt.call<AddressBloc>()),
          BlocProvider(create: (context) => ic.getIt.call<OrderBloc>()),
          BlocProvider(create: (context) => ic.getIt.call<OrderHistoryBloc>()),
          BlocProvider(create: (context) => ic.getIt.call<WalletPaymentBloc>()),
          BlocProvider(create: (context) => ic.getIt.call<WalletRequestBloc>()),
          BlocProvider(create: (context) => ic.getIt.call<WalletBloc>()),
          BlocProvider(create: (context) => ic.getIt.call<WalletHistoryBloc>()),
          BlocProvider(create: (context) => ic.getIt.call<AmountBloc>()),
          BlocProvider(
            create: (context) =>
                ic.getIt.call<TopUpHistoryBloc>()..getList(refresh: true),
          ),
        ],
        child: Sizer(
          builder: (_, orientation, deviceType) {
            return MaterialApp(
              title: 'test',
              theme: AppTheme.customTheme,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              //locale: currentLocale,
              debugShowCheckedModeBanner: false,
              navigatorKey: NavigationService.instance.navigationKey,
              onGenerateRoute: AppRoute.generateRoute,
              scaffoldMessengerKey: NavigationService.instance.messengerKey,
              home: UpgradeAlert(child: SpashScreen()),
            );
          },
        ),
      ),
    );
  }
}

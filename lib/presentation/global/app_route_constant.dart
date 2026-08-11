import 'package:b2b_freshmore/base_architecture/domain/model/order_history_model.dart';
import 'package:b2b_freshmore/presentation/screen/attachement/attachement_screen.dart';
import 'package:b2b_freshmore/presentation/screen/bookmark/screen/bookmark_screen.dart';
import 'package:b2b_freshmore/presentation/screen/cart_history/cart_screen.dart';
import 'package:b2b_freshmore/presentation/screen/change_password/password_screen.dart';
import 'package:b2b_freshmore/presentation/screen/checkout/screen/checkout_screen.dart';
import 'package:b2b_freshmore/presentation/screen/checkout/screen/order_summary_screen.dart';
import 'package:b2b_freshmore/presentation/screen/forget_password/screen/forget_password_screen.dart';
import 'package:b2b_freshmore/presentation/screen/fruits/fruits_detail_screen.dart';
import 'package:b2b_freshmore/presentation/screen/fruits/fruits_screen.dart';
import 'package:b2b_freshmore/presentation/screen/no_internet_screen.dart';
import 'package:b2b_freshmore/presentation/screen/order_history/screen/order_history_detail.dart';
import 'package:b2b_freshmore/presentation/screen/top_up_screen/screen/top_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../screen/home/home_screen.dart';
import '../screen/login/login_screen.dart';

class AppRoute {
  static dynamic callData;
  static const loginPage = '/login';
  static const home = '/home';
  static const fruits = '/fruits';
  static const fruitDetail = '/fruitDetail';
  static const password = '/password';
  static const forget = '/forget';
  static const checkout = '/checkout';
  static const orderSummary = '/orderSummary';
  static const orderHistoryDetail = '/orderHistoryDetail';
  static const cartPage = '/cart';
  static const topup = '/topup';
  static const attchment = '/attachment';
  static const bookMark = '/bookMark';
  static const noInternet = '/noInternet';

  static Route<Object>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case noInternet:
        return MaterialPageRoute(
          builder: (context) => NoInternetScreen(),
          settings: settings,
        );
      case loginPage:
        return MaterialPageRoute(
          builder: (context) => LoginScreen(),
          settings: settings,
        );
      case home:
        return MaterialPageRoute(
          builder: (context) => Homepage(),
          settings: settings,
        );
      case fruits:
        return MaterialPageRoute(
          builder: (context) {
            final String title =
                settings.arguments as String? ?? 'Default Title';
            return FruitsScreen(title: title);
          },
          settings: settings,
        );

      case password:
        return MaterialPageRoute(builder: (context) => PasswordScreen());
      case fruitDetail:
        return MaterialPageRoute(
          builder: (context) {
            var id = settings.arguments as int;
            return FruitsDetailScreen(id: id);
          },
          settings: settings,
        );

      case forget:
        return MaterialPageRoute(
          builder: (context) {
            return ForgetPasswordScreen();
          },
          settings: settings,
        );

      case checkout:
        return MaterialPageRoute(
          builder: (context) {
            return CheckoutScreen();
          },
          settings: settings,
        );

      case orderSummary:
        return MaterialPageRoute(
          builder: (context) {
            return OrderSummaryScreen();
          },
          settings: settings,
        );

      case orderHistoryDetail:
        return MaterialPageRoute(
          builder: (context) {
            var model = settings.arguments as OrderHistoryModel;
            return OrderHistoryDetailScreen(model: model);
          },
          settings: settings,
        );

      case cartPage:
        return MaterialPageRoute(
          builder: (context) {
            var navigate = (settings.arguments ?? false) as bool;
            return CartScreen(navigatFromHome: navigate);
          },
          settings: settings,
        );

      case topup:
        return MaterialPageRoute(
          builder: (context) {
            return TopUpScreen();
          },
          settings: settings,
        );

      case attchment:
        return MaterialPageRoute(
          builder: (context) {
            var model = settings.arguments as OrderHistoryModel;
            return AttachmentScreen(model: model);
          },
          settings: settings,
        );

      case bookMark:
        return MaterialPageRoute(
          builder: (context) {
            return BookmarkScreen(refreshController: RefreshController());
          },
        );

      default:
        return null;
    }
  }
}

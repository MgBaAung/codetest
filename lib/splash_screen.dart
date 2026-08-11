import 'dart:async';
import 'package:b2b_freshmore/base_architecture/data/local_datasource/token_manager.dart';
import 'package:b2b_freshmore/presentation/global/app_route_constant.dart';
import 'package:b2b_freshmore/presentation/global/app_theme.dart';
import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/image_constant.dart';
import 'package:b2b_freshmore/presentation/global/key_util.dart';
import 'package:b2b_freshmore/presentation/global/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class SpashScreen extends StatefulWidget {
  const SpashScreen({super.key});

  @override
  State<SpashScreen> createState() => _SpashScreenState();
}

class _SpashScreenState extends State<SpashScreen> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: ColorConstant.whiteColor,
        statusBarColor: ColorConstant.whiteColor,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemStatusBarContrastEnforced: false,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    setup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      body: Center(
        child: Image.asset(
          width: 400.fSize,
          height: 300.fSize,
          fit: BoxFit.cover,
          ImageConstant.logo,
        ),
      ),
    );
  }

  void setup() async {
    var tokenManager = context.read<TokenManager>();
    String? token = await tokenManager.getToken(kAccess);
    Timer(Duration(seconds: 3), () {
      if (token == null || token.isEmpty) {
        NavigationService.instance.pushNamedAndRemoveUntil(AppRoute.loginPage);
      } else {
        NavigationService.instance.pushNamedAndRemoveUntil(AppRoute.home);
      }
    });
  }
}

import 'package:b2b_freshmore/presentation/global/app_theme.dart';
import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/text_extension.dart';
import 'package:flutter/material.dart';

class AlertPasswordWidget extends StatelessWidget {
  const AlertPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: Image.asset(
            width: 178.75.fSize,
            height: 80.fSize,
            'assets/images/icons/logo.png',
          ),
        ),
        30.boxHeight,
        Align(
          alignment: Alignment.center,
          child: Text("Check your SMS", style: context.semibold(fSize: 23)),
        ),
        30.boxHeight,
        Text(
          "Password has been reset successfully.",
          style: context.semibold(
            fSize: 20,
            color: ColorConstant.primaryMainColor,
          ),
        ),
        Text(
          "New SMS has been sent",
          style: context.semibold(
            fSize: 20,
            color: ColorConstant.primaryMainColor,
          ),
        ),
        50.boxHeight
      ],
    );
  }

}

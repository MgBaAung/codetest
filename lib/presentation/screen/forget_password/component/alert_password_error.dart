import 'package:b2b_freshmore/presentation/global/app_theme.dart';
import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/text_extension.dart';
import 'package:flutter/material.dart';

class AlertPasswordError extends StatelessWidget {
  final String message;
  const AlertPasswordError({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final formattedMessage = message.replaceAll('.', '.\n');
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
          formattedMessage,
          textAlign: TextAlign.center,
          style: context.semibold(
            fSize: 20,
            color: ColorConstant.secondaryColor,
          ),
        ),

        50.boxHeight,
      ],
    );
  }
}

import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/text_extension.dart';
import 'package:flutter/material.dart';

class WalletAppBar extends StatelessWidget {
  const WalletAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 12.bottomSpacing,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Wallet",
            style: context.semibold(fSize: 20, color: ColorConstant.whiteColor),
          ),
        ],
      ),
    );
  }
}

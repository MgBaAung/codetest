import 'package:b2b_freshmore/base_architecture/domain/model/wallet_history_model.dart';
import 'package:b2b_freshmore/presentation/global/app_theme.dart';
import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/string_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/text_extension.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../global/enumeration.dart';

class TopUpItemWidget extends StatelessWidget {
  final WalletHistoryDataModel model;

  const TopUpItemWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: [4, 16].symmetricPadding,
      padding: 10.allSpacing,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: ColorConstant.whiteColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 5,
            spreadRadius: 0,
            color: ColorConstant.blcakColor.withValues(alpha: 0.1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: 4.topSpacing,
            child: Icon(
              LucideIcons.banknoteArrowUp,
              size: 32.adaptSize,
              color: ColorConstant.primaryMainColor,
            ),
          ),
          10.width,
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Top up",
                      style: context.semibold(
                        fSize: 16,
                        color: ColorConstant.primaryMainColor,
                      ),
                    ),
                    Text(
                      "${int.parse(model.amount ?? "0").toMoneyFormat()} ${model.currency}",
                      style: context.medium(fSize: 16),
                    ),
                  ],
                ),
                10.boxHeight,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (model.createdAt ?? "").changeDMYTFormat(),
                      style: context.regular(
                        fSize: 16,
                        color: ColorConstant.greyColor,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          getStatusFromString(model.status ?? "").icon,
                          size: 16.fSize,
                          color: getStatusFromString(model.status ?? "").color,
                        ),
                        2.boxWidth,
                        Text(
                          (model.status ?? "").toCapitalized(),
                          style: context.medium(
                            fSize: 16,
                            color: getStatusFromString(
                              model.status ?? "",
                            ).color,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

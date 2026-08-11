import 'package:b2b_freshmore/base_architecture/domain/model/order_history_model.dart';
import 'package:b2b_freshmore/presentation/global/app_route_constant.dart';
import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/enumeration.dart';
import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/string_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/text_extension.dart';
import 'package:b2b_freshmore/presentation/global/navigation_service.dart';
import 'package:flutter/material.dart';

class OrderHistoryItem extends StatelessWidget {
  final OrderHistoryModel model;
  const OrderHistoryItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavigationService.instance.pushNamed(
          AppRoute.orderHistoryDetail,
          args: model,
        );
      },
      child: Card(
        margin: EdgeInsets.only(top: 5),
        elevation: 0,
        child: Container(
          padding: [10, 16].symmetricPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      model.orderNo ?? "",
                      maxLines: 1,
                      style: context.medium(fSize: 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                    4.boxHeight,
                    Text(
                      "${(model.totalAmount ?? 0).toMoneyFormat()} ${model.currency ?? ""}",
                    ),
                  ],
                ),
              ),
              // Trailing Column အတွက်
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text((model.createdAt ?? "").changeDMYFormat()),
                  4.boxHeight,
                  Text(
                    (model.status ?? "").capitalize(),
                    style: context.regular(
                      fSize: 16,

                      color: getStatusFromString(model.status ?? "").color,
                    ),
                  ),
                  4.boxHeight,
                  (!check(
                            (model.paymentMethod ?? "").isEmpty
                                ? model.paymentOption ?? ""
                                : model.paymentMethod ?? "",
                          ) &&
                          model.paymentAttachmentUrl == null &&
                          (model.status ?? "").toLowerCase() ==
                              OrderStatus.pending.name)
                      ? InkWell(
                          onTap: () {
                            NavigationService.instance.pushNamed(
                              AppRoute.attchment,
                              args: model,
                            );
                          },
                          child: Text(
                            "Transaction Proof Required",
                            style: context.regular(
                              fSize: 14,
                              color: ColorConstant.primaryMainColor,
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool check(String payment) {
    switch (payment) {
      case "Cash":
        return true;
      case "B2B Wallet":
        return true;
      case "Credit":
        return true;
      case "COD":
        return true;
      default:
        return false;
    }
  }
}

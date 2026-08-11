import 'package:b2b_freshmore/base_architecture/domain/model/cart_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/order_model.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_state.dart';
import 'package:b2b_freshmore/base_architecture/state_management/cubit/order_holder_cubit.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/cart_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/order_bloc.dart';
import 'package:b2b_freshmore/presentation/global/app_bar_widget.dart';
import 'package:b2b_freshmore/presentation/global/app_route_constant.dart';
import 'package:b2b_freshmore/presentation/global/app_theme.dart';
import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/custom_button.dart';
import 'package:b2b_freshmore/presentation/global/extension/dialog_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/text_extension.dart';
import 'package:b2b_freshmore/presentation/global/generate/locale_key.g.dart';
import 'package:b2b_freshmore/presentation/global/navigation_service.dart';
import 'package:b2b_freshmore/presentation/screen/checkout/component/order_sucess_view.dart';
import 'package:b2b_freshmore/presentation/screen/checkout/component/order_summary_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderSummaryScreen extends StatefulWidget {
  const OrderSummaryScreen({super.key});

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  bool _isConfirmed = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CartListBloc, ApiState>(
          listener: (context, state) {
            if (state is ApiLoading) {
              context.showLoading();
            }
            if (state is ApiSuccess) {
              context.hideLoading();
              context.read<OrderHolderCubit>().clearOrder();
              NavigationService.instance.pushNamedAndRemoveUntil(
                AppRoute.cartPage,
              );
            }
            if (state is ApiFailure) {
              context.hideLoading();
              context.showNoticeBox(
                titleText: "Delete Order",
                contentText: state.message,
              );
            }
          },
        ),
        BlocListener<OrderBloc, ApiState>(
          listener: (context, state) {
            if (state is ApiLoading) {
              context.showLoading();
            }
            if (state is ApiSuccess<OrderModel>) {
              //context.read<OrderHolderCubit>().clearOrder();
              context.hideLoading();
              context.showContentDialog(
                child: OrderSucessView(model: state.data),
              );
            }
            if (state is ApiFailure) {
              context.hideLoading();
              context.showNoticeBox(
                titleText: "Create Order ",
                contentText: state.message,
              );
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: customAppbar(title: "Order Summary", context: context),
        body: BlocBuilder<OrderHolderCubit, OrderModel>(
          builder: (context, order) {
            if (order.orderItems == null || order.orderItems!.isEmpty) {
              return const Center(child: Text("ပစ္စည်းများ မရှိပါ။"));
            }
            return Column(
              children: [
                // Item List
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: order.orderItems!.length,
                    separatorBuilder: (_, __) => 12.boxHeight,
                    itemBuilder: (context, index) =>
                        OrderSummaryItem(data: order.orderItems![index]),
                  ),
                ),

                // Bottom Summary Section
                Container(
                  padding: [20, 20].symmetricPadding,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Payment Option:",
                            style: context.regular(fSize: 16),
                          ),
                          Text(
                            order.paymentOption?.name ?? "",
                            style: context.medium(
                              fSize: 16,
                              color: ColorConstant.primaryMainColor,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: [16, 0].symmetricPadding,
                        child: Divider(color: Color(0xFFE8E8E8)),
                      ),
                      Text(
                        "Delivery Detail",
                        style: context.semibold(fSize: 24),
                      ),
                      10.boxHeight,
                      _buildDetailRow("Shop Name:", order.address?.name ?? ""),
                      _buildDetailRow("Address:", order.address?.address ?? ""),
                      Padding(
                        padding: [10, 0].symmetricPadding,
                        child: Divider(color: Color(0xFFE8E8E8)),
                      ),
                      _buildDetailRow(
                        "Subtotal:",
                        "${calculateTotal(order.orderItems ?? []).toMoneyFormat()} ${order.orderItems?.first.currency ?? ""}",
                      ),
                      _buildDetailRow(
                        "Discount:",
                        "${(order.discountModel?.orderDiscountAmount ?? 0).toMoneyFormat()} ${order.discountModel?.currency ?? ""}",
                      ),
                      Text(
                        "(Organization Level ${order.discountModel?.currentLevel ?? 0} Privilege)",
                        style: context.regular(
                          fSize: 10,
                          color: ColorConstant.primaryMainColor,
                        ),
                      ),
                      _buildDetailRow(
                        "Total:",
                        "${((order.discountModel?.inputAmount ?? 0) - (order.discountModel?.orderDiscountAmount ?? 0)).toMoneyFormat()} ${order.orderItems?.first.currency ?? ""}",
                      ),
                      10.boxHeight,
                      Row(
                        children: [
                          Checkbox(
                            value: _isConfirmed,
                            onChanged: (v) => setState(() => _isConfirmed = v!),
                          ),
                          Text(
                            "Are you sure you want to Order it?",
                            style: context.regular(fSize: 14),
                          ),
                        ],
                      ),

                      10.boxHeight,
                      Row(
                        children: [
                          Expanded(
                            child: CustomElevatedButton(
                              onPressedFun: () {
                                context.showNoticeBox(
                                  titleText: "Clear Order",
                                  titleColor: ColorConstant.secondaryColor,
                                  contentText:
                                      "Are you sure you want to clean this order?",
                                  actions: [
                                    Container(
                                      height: 46.v,
                                      padding: 5.rightSpacing,
                                      child: CustomElevatedButton(
                                        elevation: 0.1,
                                        fSize: 16,
                                        bgColor: ColorConstant.whiteColor,
                                        borderColor: Color(0xFFE8E8E8),
                                        btnTextColor: ColorConstant.blcakColor,
                                        btnLabel: LocaleKey.lblCancel.tr(),
                                        onPressedFun: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                    Container(
                                      height: 46.v,
                                      padding: 5.leftSpacing,
                                      child: CustomElevatedButton(
                                        elevation: 0,
                                        fSize: 16,
                                        bgColor: ColorConstant.secondaryColor,
                                        btnLabel: "Delete",
                                        onPressedFun: () {
                                          context
                                              .read<CartListBloc>()
                                              .deleteCart();
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                              btnLabel: "Delete Order",
                              fSize: 16,
                              bgColor: ColorConstant.secondaryColor,
                            ),
                          ),

                          10.boxWidth,
                          Expanded(
                            child: CustomElevatedButton(
                              elevation: _isConfirmed ? null : 0,
                              onPressedFun: _isConfirmed
                                  ? () {
                                      context.read<OrderBloc>().createOrder(
                                        order,
                                      );
                                    }
                                  : () {},

                              btnLabel: "Confirm Order",
                              fSize: 16,
                              bgColor: _isConfirmed
                                  ? ColorConstant.primaryMainColor
                                  : Colors.green.shade100,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: context.regular(fSize: 16)),
          Flexible(
            child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.medium(
                fSize: 16,
                color: ColorConstant.primaryMainColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  double calculateTotal(List<DataModel> cartList) {
    double total = 0;
    for (var item in cartList) {
      total += (item.price ?? 0) * (item.quantity ?? 0);
    }
    return total;
  }

  double percentage(int perecent) {
    return perecent / 100.0;
  }
}

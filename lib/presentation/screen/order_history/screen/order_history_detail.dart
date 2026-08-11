import 'package:b2b_freshmore/base_architecture/domain/model/order_history_model.dart';
import 'package:b2b_freshmore/presentation/global/app_bar_widget.dart';
import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/text_extension.dart';
import 'package:b2b_freshmore/presentation/screen/order_history/component/order_history_detail_item.dart';
import 'package:flutter/material.dart';

class OrderHistoryDetailScreen extends StatefulWidget {
  final OrderHistoryModel model;
  const OrderHistoryDetailScreen({super.key, required this.model});

  @override
  State<OrderHistoryDetailScreen> createState() =>
      _OrderHistoryDetailScreenState();
}

class _OrderHistoryDetailScreenState extends State<OrderHistoryDetailScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showOrderDetails(context, widget.model);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: widget.model.orderNo ?? "", context: context),
      body: Padding(
        padding: 70.bottomSpacing,
        child: ListView.builder(
          itemCount: widget.model.items?.length,
          itemBuilder: (context, index) {
            return OrderHistoryDetailItem(
              data: widget.model.items![index],
              currency: widget.model.currency ?? "",
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        color: ColorConstant.whiteColor,
        padding: [0, 16].symmetricPadding,
        height: 70,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Order", style: context.semibold(fSize: 24)),
            IconButton(
              onPressed: () {
                showOrderDetails(context, widget.model);
              },
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: ColorConstant.primaryMainColor,
                size: 26,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showOrderDetails(BuildContext context, OrderHistoryModel model) {
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.transparent,
      elevation: 0,
      isScrollControlled: true,
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
      ),
      builder: (context) {
        return SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min, // Wrap content height
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Order Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle("Order"),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.keyboard_arrow_up,
                        color: ColorConstant.primaryMainColor,
                        size: 26,
                      ),
                    ),
                  ],
                ),
                _buildDetailRow("Order ID:", model.orderNo ?? ""),
                _buildDetailRow("Payment Option:", model.paymentOption ?? ""),
                _buildDetailRow("Payment Metod:", model.paymentMethod ?? ""),

                Padding(
                  padding: 10.topSpacing,
                  child: Divider(color: ColorConstant.borderStoke),
                ),

                // Delivery Detail Section
                _buildSectionTitle("Delivery Detail"),
                _buildDetailRow("Shop Name:", model.orgAddress?.name ?? ""),
                _buildDetailRow("Address:", model.orgAddress?.address ?? ""),
                Padding(
                  padding: 10.topSpacing,
                  child: Divider(color: ColorConstant.borderStoke),
                ),
                // Totals
                _buildDetailRow(
                  "Subtotal:",
                  "${(model.subtotalAmount ?? 0).toMoneyFormat()} ${model.currency ?? "MMK"}",
                ),
                _buildDetailRow(
                  "Total:",
                  "${(model.totalAmount ?? 0).toMoneyFormat()} ${model.currency ?? "MMK"}",
                  isBold: true,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Helper widget to keep code clean
  Widget _buildDetailRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: 8.topSpacing,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: context.regular(fSize: 16)),
          Flexible(
            child: Text(
              value,
              style: context.regular(fSize: 16),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(title, style: context.semibold(fSize: 24)),
    );
  }
}

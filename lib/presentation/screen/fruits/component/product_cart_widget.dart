import 'package:b2b_freshmore/base_architecture/domain/model/product_model.dart'
    show ProductModel;
import 'package:b2b_freshmore/base_architecture/state_management/implements/cart_bloc.dart';
import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/text_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCartWidget extends StatefulWidget {
  final ProductModel? product;

  const ProductCartWidget({super.key, this.product});

  @override
  State<ProductCartWidget> createState() => _ProductCartWidgetState();
}

class _ProductCartWidgetState extends State<ProductCartWidget> {
  ValueNotifier<int> quantity = ValueNotifier(1);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: 0.allSpacing,
      padding: [0, 14].symmetricPadding,
      decoration: BoxDecoration(
        color: ColorConstant.whiteColor,
        border: Border(
          top: BorderSide(color: ColorConstant.borderStoke, width: 1),
        ),
      ),
      height: 100,
      child: SafeArea(
        child: Row(
          children: [
            Container(
              padding: [7, 7].symmetricPadding,
              decoration: BoxDecoration(
                color: ColorConstant.whiteColor,
                borderRadius: BorderRadius.circular(149),
                border: Border.all(color: ColorConstant.borderStoke, width: 1),
              ),
              child: Row(
                children: [
                  ValueListenableBuilder(
                    valueListenable: quantity,
                    builder: (context, value, child) {
                      return button(
                        onPressed: () {
                          if (quantity.value > 1) {
                            quantity.value--;
                          }
                        },
                        color: value == 1
                            ? ColorConstant.borderStoke
                            : ColorConstant.primaryMainColor,
                        icon: Icons.remove,
                      );
                    },
                  ),

                  Container(
                    width: 50,
                    height: 20,
                    padding: [0, 0].symmetricPadding,
                    child: ValueListenableBuilder<int>(
                      valueListenable: quantity,
                      builder: (context, value, child) {
                        return Center(
                          child: Text(
                            "$value",
                            style: context.regular(fSize: 14),
                          ),
                        );
                      },
                    ),
                  ),

                  button(
                    onPressed: () {
                      quantity.value++;
                    },
                  ),
                ],
              ),
            ),
            12.boxWidth,
            InkWell(
              onTap: () {
                quantity.value = 1;
              },
              child: Container(
                height: 44,
                width: 80,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorConstant.borderStoke,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text("Clear", style: context.medium(fSize: 16)),
                ),
              ),
            ),
            12.boxWidth,
            InkWell(
              onTap: (widget.product?.productData?.first.price ?? 0) > 0
                  ? () {
                      context.read<CartBloc>().addToCart(
                        model: widget.product,
                        quantity: quantity.value,
                      );
                    }
                  : () {},
              child: Container(
                height: 44,
                width: 100,
                decoration: BoxDecoration(
                  color: (widget.product?.productData?.first.price ?? 0) > 0
                      ? ColorConstant.primaryMainColor
                      : Colors.green.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Add to Cart",
                    style: context.medium(color: ColorConstant.whiteColor),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget button({
    required VoidCallback onPressed,
    IconData icon = Icons.add,
    Color? color,
  }) {
    return Container(
      height: 30,
      width: 30,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: color ?? ColorConstant.primaryMainColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        icon: Icon(icon, color: ColorConstant.whiteColor),
      ),
    );
  }
}

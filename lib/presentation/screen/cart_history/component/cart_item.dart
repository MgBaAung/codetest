import 'package:b2b_freshmore/base_architecture/domain/model/cart_model.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_state.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/cart_bloc.dart';
import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/text_extension.dart';
import 'package:b2b_freshmore/presentation/global/image_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:shimmer/shimmer.dart';

class CartItem extends StatefulWidget {
  final DataModel cart;
  final ValueNotifier valueNotifier;
  final ValueNotifier changeQty;

  const CartItem({
    super.key,
    required this.cart,
    required this.valueNotifier,
    required this.changeQty,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  late ValueNotifier<int> quantity;
  @override
  void initState() {
    quantity = ValueNotifier(widget.cart.quantity ?? 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey(widget.cart.id ?? 1),
      margin: [0, 16].symmetricPadding,
      padding: 10.leftSpacing,
      decoration: BoxDecoration(
        color: ColorConstant.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border(
          top: BorderSide(color: ColorConstant.borderStoke, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x2121211A),
            blurRadius: 1,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.cart.product?.nameEn ?? "",
                  style: context.bold(fSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              BlocBuilder<CartListBloc, ApiState>(
                builder: (context, state) {
                  var noState = state is ApiNoState;
                  return IconButton(
                    onPressed: noState
                        ? () {}
                        : () {
                            context.read<CartListBloc>().deleteCart(
                              id: (widget.cart.id ?? 0).toInt(),
                            );
                          },
                    icon: Icon(
                      LucideIcons.trash2,
                      color: ColorConstant.secondaryColor,
                    ),
                  );
                },
              ),
            ],
          ),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(2.0),
                child: CachedNetworkImage(
                  cacheManager: GetIt.I<CacheManager>(),
                  imageUrl: widget.cart.product?.images?.first.url ?? "",
                  fit: BoxFit.fill,
                  width: 72,
                  height: 72,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(color: Colors.white),
                  ),
                  cacheKey: (widget.cart.product?.images?.first.url ?? "")
                      .split("?")
                      .first,
                  useOldImageOnUrlChange: true,
                  errorWidget: (context, url, error) =>
                      Image.asset(ImageConstant.noproduct, fit: BoxFit.cover),
                ),
              ),
              12.boxWidth,
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    " ${widget.cart.product?.uomQty ?? 1} ${widget.cart.product?.unit?.name ?? ""}",
                    style: context.regular(fSize: 12),
                  ),
                  SizedBox(height: 4),
                  ValueListenableBuilder(
                    valueListenable: quantity,
                    builder: (context, value, child) {
                      return Text(
                        "${((widget.cart.price ?? 0) * (widget.cart.quantity ?? 1)).toMoneyFormat()} ${(widget.cart.currency ?? "").toLowerCase()}",
                        style: context.semibold(fSize: 12),
                      );
                    },
                  ),
                ],
              ),
              Spacer(),
              Container(
                padding: [7, 7].symmetricPadding,
                decoration: BoxDecoration(
                  color: ColorConstant.whiteColor,
                  borderRadius: BorderRadius.circular(149),
                  border: Border.all(
                    color: ColorConstant.borderStoke,
                    width: 1,
                  ),
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
                              widget.cart.quantity = quantity.value;
                              widget.valueNotifier.value = true;
                              widget.changeQty.value--;
                            }
                          },
                          icon: Icons.remove,
                          color: value == 1
                              ? ColorConstant.borderStoke
                              : ColorConstant.primaryMainColor,
                        );
                      },
                    ),

                    ValueListenableBuilder<int>(
                      valueListenable: quantity,
                      builder: (context, value, child) {
                        return SizedBox(
                          width: 40,
                          child: Center(
                            child: Text(
                              "$value",
                              style: context.regular(fSize: 14),
                            ),
                          ),
                        );
                      },
                    ),
                    button(
                      onPressed: () {
                        quantity.value++;
                        widget.cart.quantity = quantity.value;
                        widget.valueNotifier.value = true;
                        widget.changeQty.value++;
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(width: 12),
            ],
          ),
          15.boxHeight,
        ],
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

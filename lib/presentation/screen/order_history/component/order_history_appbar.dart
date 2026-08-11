import 'package:b2b_freshmore/base_architecture/state_management/implements/order_history_bloc.dart';
import 'package:b2b_freshmore/presentation/global/app_theme.dart';
import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/text_extension.dart';
import 'package:b2b_freshmore/presentation/global/size_constant.dart';
import 'package:b2b_freshmore/presentation/screen/order_history/component/filter_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class OrderHistoryAppbar extends StatefulWidget {
  final TextEditingController controller;
  const OrderHistoryAppbar({super.key, required this.controller});

  @override
  // ignore: library_private_types_in_public_api
  _OrderHistoryAppbarState createState() => _OrderHistoryAppbarState();
}

class _OrderHistoryAppbarState extends State<OrderHistoryAppbar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 60,
          padding: 16.leftSpacing,
          width: double.infinity,
          color: ColorConstant.primaryMainColor,
          alignment: Alignment.centerLeft,
          child: Text(
            "Order History",
            style: context.semibold(fSize: 20, color: ColorConstant.whiteColor),
          ),
        ),
        14.boxHeight,
        Container(
          margin: [0, 20].symmetricPadding,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  controller: widget.controller,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: "Search Order",
                    hintStyle: context.regular(
                      color: ColorConstant.greyColor,
                      fSize: SizeConstant.f1,
                    ),
                    suffixIcon: ValueListenableBuilder<TextEditingValue>(
                      valueListenable: widget.controller,
                      builder: (context, value, child) {
                        return value.text.isEmpty
                            ? IconButton(
                                onPressed: () {
                                  if (widget.controller.text.isNotEmpty) {
                                    context.read<OrderHistoryBloc>().getList(
                                      keywords: widget.controller.text,
                                    );
                                  }
                                },
                                icon: Icon(
                                  LucideIcons.search,
                                  size: 18.fSize,
                                  color: ColorConstant.greyColor,
                                ),
                              )
                            : IconButton(
                                onPressed: () {
                                  widget.controller.clear();
                                  context.read<OrderHistoryBloc>().clean();
                                  context.read<OrderHistoryBloc>().getList();
                                },
                                icon: Icon(
                                  Icons.close,
                                  size: 18.fSize,
                                  color: ColorConstant.greyColor,
                                ),
                              );
                      },
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorConstant.borderStoke),
                      borderRadius: BorderRadius.circular(SizeConstant.s2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorConstant.borderStoke),
                      borderRadius: BorderRadius.circular(SizeConstant.s2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorConstant.borderStoke),
                      borderRadius: BorderRadius.circular(SizeConstant.s2),
                    ),
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  ),
                  onSubmitted: (value) {
                    context.read<OrderHistoryBloc>().getList(
                      keywords: widget.controller.text,
                    );
                  },
                ),
              ),

              FilterIconWidget(textEditingController: widget.controller),
            ],
          ),
        ),
        10.boxHeight,
      ],
    );
  }
}

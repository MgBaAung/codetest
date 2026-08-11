import 'package:b2b_freshmore/base_architecture/domain/model/order_history_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/user_model.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_state.dart';
import 'package:b2b_freshmore/base_architecture/state_management/cubit/bottom_nav_cubit.dart';
import 'package:b2b_freshmore/base_architecture/state_management/cubit/holder_cubilt.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/auth_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/cart_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/order_history_bloc.dart';
import 'package:b2b_freshmore/injection_container.dart';
import 'package:b2b_freshmore/presentation/global/app_route_constant.dart';
import 'package:b2b_freshmore/presentation/global/app_theme.dart';
import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/enumeration.dart';
import 'package:b2b_freshmore/presentation/global/extension/dialog_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/string_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/text_extension.dart';
import 'package:b2b_freshmore/presentation/global/navigation_service.dart';
import 'package:b2b_freshmore/presentation/global/size_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class HomeAppbarContent extends StatefulWidget {
  final TextEditingController controller;
  const HomeAppbarContent({super.key, required this.controller});

  @override
  State<HomeAppbarContent> createState() => _HomeAppbarContentState();
}

class _HomeAppbarContentState extends State<HomeAppbarContent> {
  var user = getIt.call<HolderCubit>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderHistoryBloc, ApiState>(
      listener: (context, state) {
        if (state is ApiSuccess<List<OrderHistoryModel>>) {
          context.hideLoading();
        }
      },
      child: BlocBuilder<AuthBloc, ApiState>(
        builder: (context, state) {
          UserModel? userModel;
          if (state is ApiSuccess<UserModel>) {
            userModel = state.data;
            user.setIndex((userModel.id ?? 0).toInt());
          }
          return Padding(
            padding: 4.leftSpacing,
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.read<BottomNavCubit>().navIndexChange(
                          AppNavTab.profile,
                        );
                      },
                      child: Container(
                        height: 45.fSize,
                        width: 45.fSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: ColorConstant.primaryMainColor,
                        ),
                        child: Center(
                          child: Text(
                            getInitials(userModel?.userName ?? ""),
                            textAlign: TextAlign.center,
                            style: context.medium(
                              color: ColorConstant.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizeConstant.f3.boxWidth,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${userModel?.userName}",
                            style: context.bold(fSize: 16),
                          ),
                          Text(
                            userModel?.organizationName ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.regular(fSize: SizeConstant.f2),
                          ),
                        ],
                      ),
                    ),

                    InkWell(
                      onTap: () {
                        NavigationService.instance.pushNamed(
                          AppRoute.cartPage,
                          args: true,
                        );
                      },
                      child: Stack(
                        children: [
                          Icon(
                            LucideIcons.shoppingBasket,
                            color: ColorConstant.primaryMainColor,
                          ),
                          Positioned(
                            child: BlocBuilder<CartListBloc, ApiState>(
                              builder: (context, state) {
                                return context
                                            .read<CartListBloc>()
                                            .cartCount() ==
                                        0
                                    ? SizedBox.shrink()
                                    : Container(
                                        height: 18,
                                        width: 18,
                                        decoration: BoxDecoration(
                                          color: ColorConstant.secondaryColor,
                                          borderRadius: BorderRadius.circular(
                                            100,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "${context.read<CartListBloc>().cartCount()}",
                                            textAlign: TextAlign.center,
                                            style: context.regular(
                                              fSize: SizeConstant.s2,
                                              color: ColorConstant.whiteColor,
                                            ),
                                          ),
                                        ),
                                      );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                14.boxHeight,
              ],
            ),
          );
        },
      ),
    );
  }
}

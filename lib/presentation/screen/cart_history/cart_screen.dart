import 'package:b2b_freshmore/base_architecture/domain/model/cart_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/order_model.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_state.dart';
import 'package:b2b_freshmore/base_architecture/state_management/cubit/bottom_nav_cubit.dart';
import 'package:b2b_freshmore/base_architecture/state_management/cubit/order_holder_cubit.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/address_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/cart_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/order_history_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/payment_bloc.dart';
import 'package:b2b_freshmore/presentation/global/app_bar_widget.dart';
import 'package:b2b_freshmore/presentation/global/app_route_constant.dart';
import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/custom_button.dart';
import 'package:b2b_freshmore/presentation/global/custom_error_widget.dart';
import 'package:b2b_freshmore/presentation/global/enumeration.dart';
import 'package:b2b_freshmore/presentation/global/extension/dialog_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/text_extension.dart';
import 'package:b2b_freshmore/presentation/global/image_constant.dart';
import 'package:b2b_freshmore/presentation/global/navigation_service.dart';
import 'package:b2b_freshmore/presentation/screen/cart_history/component/cart_item.dart';
import 'package:b2b_freshmore/presentation/screen/cart_history/component/cart_shimmer_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CartScreen extends StatefulWidget {
  final bool? navigatFromHome;
  const CartScreen({super.key, this.navigatFromHome = false});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );
  ValueNotifier<bool> isChanged = ValueNotifier(false);
  List<DataModel> cartList = [];
  ValueNotifier<int> changeQty = ValueNotifier(0);
  OrderModel orderModel = OrderModel();

  @override
  initState() {
    context.read<CartListBloc>().getCartList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        NavigationService.instance.pushNamedAndRemoveUntil(AppRoute.home);
      },
      child: MultiBlocListener(
        listeners: [
          BlocListener<CartListBloc, ApiState>(
            listener: (context, state) {
              if (state is ApiFailure) {
                context.showNoticeBox(
                  titleText: "Cart History",
                  contentText: state.message,
                );
              }

              if (state is ApiSuccess<CartModel>) {
                if (state.data.data!.isEmpty && !widget.navigatFromHome!) {
                  context.hideLoading();
                }
                _refreshController.loadComplete();
                _refreshController.refreshCompleted();
                isChanged.value = false;
                cartList = state.data.data ?? [];
                cartList.sort((a, b) => (a.id ?? 0).compareTo(b.id ?? 0));
                orderModel.orderItems = List<DataModel>.from(cartList);
                orderModel.discountModel = state.data.discountModel;
              }
            },
          ),
          BlocListener<AddressBloc, ApiState>(
            listener: (context, state) {
              if (state is ApiLoading) {
                context.showLoading();
              }
              if (state is ApiFailure) {
                context.hideLoading();
                context.showNoticeBox(
                  titleText: "Address",
                  contentText: state.message,
                );
              }
              if (state is ApiSuccess) {
                context.hideLoading();
                NavigationService.instance.pushNamed(AppRoute.checkout);
              }
            },
          ),
          BlocListener<OrderHolderCubit, OrderModel>(
            listener: (context, state) {
              orderModel = state;
            },
          ),
        ],
        child: Scaffold(
          appBar: customAppbar(
            title: "Cart",
            context: context,
            onPressed: () {
              NavigationService.instance.pushNamedAndRemoveUntil(AppRoute.home);
            },
            actions: [
              IconButton(
                onPressed: () {
                  context.read<OrderHistoryBloc>().getList();
                  NavigationService.instance.pushNamedAndRemoveUntil(
                    AppRoute.home,
                  );
                  context.read<BottomNavCubit>().navIndexChange(
                    AppNavTab.order,
                  );
                },
                icon: Icon(
                  LucideIcons.clipboardClock,
                  color: ColorConstant.whiteColor,
                ),
              ),
              6.boxWidth,
            ],
          ),
          body: BlocBuilder<CartListBloc, ApiState>(
            builder: (context, state) {
              if (state is ApiSuccess<CartModel>) {
                if (cartList.isEmpty == true) {
                  return Center(
                    child: Image.asset(
                      ImageConstant.emptyCart,
                      width: 150,
                      height: 150,
                    ),
                  );
                }
              }
              return Stack(
                children: [
                  SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: false,
                    header: WaterDropHeader(),
                    controller: _refreshController,
                    onRefresh: () => context.read<CartListBloc>().getCartList(),
                    child: CustomScrollView(
                      slivers: [
                        const SliverToBoxAdapter(child: SizedBox(height: 15)),
                        BlocBuilder<CartListBloc, ApiState>(
                          builder: (context, state) {
                            if (state is ApiFailure) {
                              return SliverToBoxAdapter(
                                child: ApiErrorWidget(
                                  onRetry: () {
                                    context.read<CartListBloc>().getCartList();
                                  },
                                ),
                              );
                            } else if (state is ApiLoading) {
                              return SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) => const ShimmerCartItem(),
                                  childCount: 5,
                                ),
                              );
                            }
                            return SliverList.separated(
                              itemCount: cartList.length,
                              itemBuilder: (context, index) {
                                final cartData = cartList[index];
                                return CartItem(
                                  cart: cartData,
                                  valueNotifier: isChanged,
                                  changeQty: changeQty,
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  10.boxHeight,
                            );
                          },
                        ),
                        const SliverToBoxAdapter(child: SizedBox(height: 190)),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: BlocBuilder<CartListBloc, ApiState>(
                      builder: (context, state) {
                        return Container(
                          padding: [4, 16].symmetricPadding,
                          color: Colors.white,
                          child: SafeArea(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Cart Total",
                                  style: context.semibold(fSize: 24),
                                ),
                                10.boxHeight,
                                cartText(name: "Sub Total", price: 100000),
                                10.boxHeight,
                                cartText(name: "Total", price: 100000),
                                10.boxHeight,
                                SizedBox(
                                  width: double.infinity,
                                  child: ValueListenableBuilder<bool>(
                                    valueListenable: isChanged,
                                    builder: (context, value, child) {
                                      return value
                                          ? CustomElevatedButton(
                                              onPressedFun: () {
                                                context
                                                    .read<CartListBloc>()
                                                    .buildkartList(cartList);
                                              },
                                              btnLabel: "Update cart",
                                              fSize: 16,
                                            )
                                          : CustomElevatedButton(
                                              onPressedFun: () {
                                                context
                                                    .read<PaymentBloc>()
                                                    .getPaymentList();
                                                context
                                                    .read<OrderHolderCubit>()
                                                    .setOrder(orderModel);
                                                context
                                                    .read<AddressBloc>()
                                                    .getAddressList();
                                              },
                                              btnLabel: "Place Order",
                                              fSize: 16,
                                            );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget cartText({required String name, required double price}) {
    return ValueListenableBuilder(
      valueListenable: changeQty,
      builder: (context, value, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("$name:", style: context.regular(fSize: 16)),
            Text(
              "${calculateTotal().toMoneyFormat()} ${cartList.isNotEmpty ? cartList.first.currency ?? "" : ""}",
              style: context.medium(
                fSize: 16,
                color: ColorConstant.primaryMainColor,
              ),
            ),
          ],
        );
      },
    );
  }

  double calculateTotal() {
    double total = 0;
    for (var item in cartList) {
      total += (item.price ?? 0) * (item.quantity ?? 0);
    }
    return total;
  }
}

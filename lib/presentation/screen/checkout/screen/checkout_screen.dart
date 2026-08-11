import 'package:b2b_freshmore/base_architecture/domain/model/address_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/order_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/payment_model.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_state.dart';
import 'package:b2b_freshmore/base_architecture/state_management/cubit/order_holder_cubit.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/payment_bloc.dart';
import 'package:b2b_freshmore/presentation/global/app_bar_widget.dart';
import 'package:b2b_freshmore/presentation/global/app_route_constant.dart';
import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/custom_button.dart';
import 'package:b2b_freshmore/presentation/global/custom_text_field.dart';
import 'package:b2b_freshmore/presentation/global/drop_down_text_input.dart';
import 'package:b2b_freshmore/presentation/global/extension/dialog_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/text_extension.dart';
import 'package:b2b_freshmore/presentation/global/navigation_service.dart';
import 'package:b2b_freshmore/presentation/screen/checkout/component/payment_item_widget.dart';
import 'package:b2b_freshmore/presentation/screen/checkout/component/payment_option_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _pointController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _latontroller = TextEditingController();
  final TextEditingController _longController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  ValueNotifier<DeliveryOption> selectLocation = ValueNotifier(
    DeliveryOption.point,
  );
  AddressData? selectedAddress;
  PaymentModel? selectedPayment;
  SingingCharacter? _character = SingingCharacter.paynow;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PaymentBloc, ApiState>(
          listener: (context, state) {
            if (state is ApiSuccess<List<PaymentModel>>) {
              // _refreshController.refreshCompleted();
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: customAppbar(title: "Place Order", context: context),
        body: BlocBuilder<OrderHolderCubit, OrderModel>(
          builder: (context, states) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<PaymentBloc>().getPaymentList();
              },
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        // Delivery Details Container
                        Container(
                          margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ValueListenableBuilder<DeliveryOption>(
                            valueListenable: selectLocation,
                            builder: (context, value, child) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text(
                                  //   "Delivery Details",
                                  //   style: context.semibold(fSize: 24),
                                  // ),
                                  // 20.boxHeight,
                                  // Container(
                                  //   height: 60,
                                  //   width: double.infinity,
                                  //   padding: [0, 5].symmetricPadding,
                                  //   decoration: BoxDecoration(
                                  //     border: Border.all(
                                  //       color: ColorConstant.borderStoke,
                                  //     ),
                                  //     borderRadius: BorderRadius.circular(6),
                                  //   ),
                                  //   child: Row(
                                  //     children: [
                                  //       Expanded(
                                  //         child: CustomElevatedButton(
                                  //           elevation: 0,
                                  //           onPressedFun: () {
                                  //             selectLocation.value =
                                  //                 DeliveryOption.point;
                                  //           },
                                  //           btnLabel: "Select Point",
                                  //           fSize: 14,
                                  //           radius: 4,
                                  //           bgColor:
                                  //               selectLocation.value ==
                                  //                   DeliveryOption.point
                                  //               ? ColorConstant.primaryMainColor
                                  //               : Colors.white,
                                  //           btnTextColor:
                                  //               selectLocation.value ==
                                  //                   DeliveryOption.point
                                  //               ? ColorConstant.whiteColor
                                  //               : ColorConstant.primaryMainColor,
                                  //         ),
                                  //       ),
                                  //       Expanded(
                                  //         child: CustomElevatedButton(
                                  //           elevation: 0,
                                  //           onPressedFun: () {
                                  //             selectLocation.value =
                                  //                 DeliveryOption.location;
                                  //           },
                                  //           btnLabel: "Enter Location",
                                  //           fSize: 14,
                                  //           radius: 4,
                                  //           bgColor:
                                  //               selectLocation.value ==
                                  //                   DeliveryOption.location
                                  //               ? ColorConstant.primaryMainColor
                                  //               : Colors.white,
                                  //           btnTextColor:
                                  //               selectLocation.value ==
                                  //                   DeliveryOption.location
                                  //               ? ColorConstant.whiteColor
                                  //               : ColorConstant.primaryMainColor,
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  // 20.boxHeight,
                                  // value == DeliveryOption.point
                                  //     ?
                                  deliveryPoint(),
                                  // : location(),
                                ],
                              );
                            },
                          ),
                        ),
                        // Payment Methods
                        Expanded(
                          child: Container(
                            padding: [16, 16].symmetricPadding,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Payment Option",
                                  style: context.semibold(fSize: 24),
                                ),
                                6.boxHeight,
                                PaymentOptionItem(
                                  onChanged: (value) {
                                    setState(() {
                                      _character = value;
                                    });
                                  },
                                  character:
                                      _character ?? SingingCharacter.paynow,
                                ),
                                _character != SingingCharacter.paynow
                                    ? Container()
                                    : Expanded(
                                        child: ListView(
                                          children: [
                                            10.boxHeight,
                                            Divider(color: Color(0xFFE8E8E8)),
                                            10.boxHeight,
                                            Text(
                                              "Payment Methods",
                                              style: context.semibold(
                                                fSize: 24,
                                              ),
                                            ),
                                            10.boxHeight,
                                            PaymentItemWidget(
                                              selectedPayment: selectedPayment,
                                              onTap: (value) {
                                                setState(() {
                                                  selectedPayment = value;
                                                });
                                              },
                                            ),
                                            10.boxHeight,
                                          ],
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: [2, 16].symmetricPadding,
                    child: SafeArea(
                      child: CustomElevatedButton(
                        onPressedFun: () {
                          var model = states;
                          model.address = selectedAddress;
                          model.payment = selectedPayment;
                          model.paymentOption = _character;
                          context.read<OrderHolderCubit>().setOrder(model);
                          bool isPaymentValid =
                              (model.paymentOption !=
                                  SingingCharacter.paynow) ||
                              (model.payment != null);
                          if (model.address != null && isPaymentValid) {
                            NavigationService.instance.pushNamed(
                              AppRoute.orderSummary,
                            );
                            return;
                          } else {
                            if (selectedAddress == null) {
                              context.showNoticeBox(
                                titleText: "Select Address",
                                titleColor: ColorConstant.primaryMainColor,
                                contentText: "Select address in dropdown",
                              );
                            }

                            if (model.paymentOption ==
                                    SingingCharacter.paynow &&
                                selectedPayment == null) {
                              context.showNoticeBox(
                                titleColor: ColorConstant.primaryMainColor,
                                titleText: "Select Payments",
                                contentText: "Select payment",
                              );
                            }
                          }
                        },
                        btnLabel: "Proceed to checkout",
                        fSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            maxLines: 1,
            style: context.regular(fSize: 16, color: ColorConstant.greyColor),
            overflow: TextOverflow.ellipsis,
          ),
          Flexible(
            child: Text(
              value,
              style: context.regular(fSize: 14),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget deliveryPoint() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textWithStar("Delivery Point"),
        8.boxHeight,
        AddressDropDown(
          controller: _roleController,
          hintText: "Select delivery point",
          callBack: (value) {
            setState(() {
              selectedAddress = value;
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'select delivery point!';
            }
            return null;
          },
        ),
        8.boxHeight,
        selectedAddress == null
            ? SizedBox.shrink()
            : _buildInfoRow("Address:", selectedAddress?.address ?? ""),
        selectedAddress == null
            ? SizedBox.shrink()
            : _buildInfoRow("Latitude:", selectedAddress?.latitude ?? ""),
        selectedAddress == null
            ? SizedBox.shrink()
            : _buildInfoRow("Longitude:", selectedAddress?.longitude ?? ""),
      ],
    );
  }

  Widget location() {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPaymentMethod(
            "Delivery Point Name",
            'delivery point name',
            _pointController,
          ),
          15.boxHeight,
          _buildPaymentMethod("Address", 'your address', _addressController),
          15.boxHeight,
          _buildPaymentMethod("Latitude", 'latitude', _latontroller),
          15.boxHeight,
          _buildPaymentMethod("Longitude", 'longitude', _longController),
        ],
      ),
    );
  }

  Widget _buildPaymentMethod(
    String label,
    String method,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        textWithStar(method),
        4.boxHeight,
        CustomTextFormField(
          hintText: "Enter $method",
          textEditingController: controller,
        ),
      ],
    );
  }

  Widget textWithStar(String label) {
    return Text.rich(
      TextSpan(
        text: "Delivery Point",
        style: context.regular(fSize: 16),
        children: [
          TextSpan(
            text: " *",
            style: context.regular(
              fSize: 16,
              color: ColorConstant.secondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

enum DeliveryOption { point, location }

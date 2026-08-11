import 'package:b2b_freshmore/base_architecture/domain/model/attachement_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/order_model.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_state.dart';
import 'package:b2b_freshmore/base_architecture/state_management/cubit/bottom_nav_cubit.dart';
import 'package:b2b_freshmore/base_architecture/state_management/cubit/order_holder_cubit.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/attachement_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/order_history_bloc.dart';
import 'package:b2b_freshmore/injection_container.dart' as ic;
import 'package:b2b_freshmore/presentation/global/app_route_constant.dart';
import 'package:b2b_freshmore/presentation/global/app_theme.dart';
import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/custom_button.dart';
import 'package:b2b_freshmore/presentation/global/enumeration.dart';
import 'package:b2b_freshmore/presentation/global/extension/dialog_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/text_extension.dart';
import 'package:b2b_freshmore/presentation/global/navigation_service.dart';
import 'package:b2b_freshmore/presentation/screen/wallet/component/choose_file_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class OrderSucessView extends StatefulWidget {
  final OrderModel model;
  const OrderSucessView({super.key, required this.model});

  @override
  State<OrderSucessView> createState() => _OrderSucessViewState();
}

class _OrderSucessViewState extends State<OrderSucessView> {
  String checkName = "";
  AttachementModel? model = AttachementModel();
  @override
  void initState() {
    checkName =
        (widget.model.paymentMethod != null &&
            widget.model.paymentMethod!.isEmpty)
        ? widget.model.paymentMethod ?? ""
        : widget.model.paymentOptionName ?? "";
    model?.id = widget.model.id;
    super.initState();
  }

  @override
  void dispose() {
    model = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return check(
          (widget.model.paymentMethod ?? "").isEmpty
              ? widget.model.paymentOptionName ?? ""
              : widget.model.paymentMethod ?? "",
        )
        ? SizedBox(
            height: 340.v,
            child: Column(
              children: [
                18.boxHeight,
                Align(
                  alignment: AlignmentGeometry.center,
                  child: Container(
                    height: 97.v,
                    width: 97.v,
                    decoration: BoxDecoration(
                      color: ColorConstant.primaryMainColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      color: ColorConstant.whiteColor,
                      size: 50,
                    ),
                  ),
                ),
                10.boxHeight,
                Center(
                  child: Text(
                    "Order Successful!",
                    style: context.semibold(fSize: 40),
                  ),
                ),
                20.boxHeight,
                CustomElevatedButton(
                  btnLabel: "Go to Order Page",
                  fSize: 16,
                  onPressedFun: () {
                    context.hideLoading();
                    context.read<OrderHistoryBloc>().getList();
                    NavigationService.instance.pushNamedAndRemoveUntil(
                      AppRoute.home,
                    );
                    context.read<BottomNavCubit>().navIndexChange(
                      AppNavTab.order,
                    );
                  },
                  elevation: 0,
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      context.hideLoading();
                      NavigationService.instance.pushNamedAndRemoveUntil(
                        AppRoute.home,
                      );
                    },
                    child: Text(
                      "Back to Home",
                      style: context.light(fSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          )
        : BlocProvider(
            create: (context) => ic.getIt.call<AttachementBloc>(),
            child: Builder(
              builder: (context) {
                return BlocListener<AttachementBloc, ApiState>(
                  listener: (context, state) {
                    if (state is ApiSuccess<AttachementModel>) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.only(
                            bottom: 50,
                            left: 16,
                            right: 16,
                          ),
                          backgroundColor: ColorConstant.whiteColor,
                          content: Row(
                            children: [
                              Icon(
                                LucideIcons.circleCheck,
                                color: ColorConstant.primaryMainColor,
                              ),
                              8.boxWidth,
                              Text(
                                "Payment Proof Uploaded Successfully",
                                style: context.regular(
                                  fSize: 14,
                                  color: ColorConstant.primaryMainColor,
                                ),
                              ),
                            ],
                          ),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                      NavigationService.instance.pushNamedAndRemoveUntil(
                        AppRoute.home,
                      );
                    }
                  },
                  child: BlocBuilder<OrderHolderCubit, OrderModel>(
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          18.boxHeight,
                          Align(
                            alignment: AlignmentGeometry.center,
                            child: Container(
                              height: 97.v,
                              width: 97.v,
                              decoration: BoxDecoration(
                                color: ColorConstant.primaryMainColor,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.check,
                                color: ColorConstant.whiteColor,
                                size: 50,
                              ),
                            ),
                          ),
                          10.boxHeight,
                          Center(
                            child: Text(
                              "Order Successful!",
                              style: context.semibold(fSize: 40),
                            ),
                          ),
                          20.boxHeight,
                          _buildInfoRow(
                            prefixIcon: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                width: 24.fSize,
                                height: 24.fSize,
                                color: const Color(0xFFF9D5B8),
                                child: CachedNetworkImage(
                                  cacheManager: GetIt.I<CacheManager>(),
                                  imageUrl: widget.model.payment?.logoUrl ?? "",
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                  cacheKey:
                                      (widget.model.payment?.logoUrl ?? "")
                                          .split("?")
                                          .first,
                                  errorWidget: (context, url, error) => Icon(
                                    Icons.image_not_supported,
                                    color: Colors.grey,
                                  ),
                                  useOldImageOnUrlChange: true,
                                ),
                              ),
                            ),

                            context: context,
                            value: " ${widget.model.paymentMethod}",
                            label: "Payment Method:",
                          ),
                          _buildInfoRow(
                            context: context,
                            value: state.payment?.trasferAccountName ?? "",
                            label: "Transfer Account Name :",
                          ),

                          _buildInfoRow(
                            context: context,
                            value: "${state.payment?.trasferAccountNo ?? ""} ",
                            label: "Transfer Account Number :",
                            copyIcon: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                splashColor: Colors.grey.withValues(alpha: 0.3),
                                highlightColor: Colors.grey.withValues(
                                  alpha: (0.1),
                                ),
                                onTap: () {
                                  Clipboard.setData(
                                    ClipboardData(
                                      text:
                                          state.payment?.trasferAccountNo ?? "",
                                    ),
                                  ).then((_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(" copied to clipboard ${ state.payment?.trasferAccountNo ?? ""}"),
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                  });
                                },
                                child: Icon(
                                  LucideIcons.copy,
                                  size: 18,
                                  color: ColorConstant.primaryMainColor,
                                ),
                              ),
                            ),
                          ),
                          _buildInfoRow(
                            context: context,
                            value: "${widget.model.id}",
                            label: "Order ID",
                          ),
                          10.boxHeight,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              labelText(
                                context: context,
                                label: "Attachment File",
                              ),
                              Text(
                                "Maximum file size: 10 MB.",
                                style: context.regular(
                                  fSize: 14,
                                  color: ColorConstant.secondaryColor,
                                ),
                              ),
                            ],
                          ),
                          ChooseFileWidget(
                            callBack: (fil) {
                              model?.file = fil;
                            },
                          ),
                          18.boxHeight,
                          BlocBuilder<AttachementBloc, ApiState>(
                            builder: (context, state) {
                              if (state is ApiFailure) {
                                return CustomElevatedButton(
                                  fSize: 16,
                                  elevation: 0,
                                  btnLabel: "Try again",
                                  onPressedFun: () {
                                    context
                                        .read<AttachementBloc>()
                                        .uploadAttachement(model!);
                                  },
                                );
                              }
                              if (state is ApiLoading) {
                                return CustomElevatedButton(
                                  fSize: 16,
                                  elevation: 0,
                                  btnLabel: "Processing...",
                                  onPressedFun: () {},
                                );
                              }
                              return CustomElevatedButton(
                                fSize: 16,
                                elevation: 0,
                                btnLabel: "Submit",
                                onPressedFun: () {
                                  if (model!.file == null) {
                                    context.showNoticeBox(
                                      titleText: "Attachment",
                                      contentText: "Please choose file!.",
                                    );
                                  } else {
                                    context
                                        .read<AttachementBloc>()
                                        .uploadAttachement(model!);
                                  }
                                },
                              );
                            },
                          ),
                          20.boxHeight,
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 1,
                                  color: ColorConstant.borderStoke,
                                ),
                              ),
                              Text(
                                " or ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                  color: ColorConstant.borderStoke,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 1,
                                  color: ColorConstant.borderStoke,
                                ),
                              ),
                            ],
                          ),
                          10.boxHeight,
                          Center(
                            child: Text.rich(
                              textAlign: TextAlign.center,
                              TextSpan(
                                text:
                                    "Upload your Transferred Screenshot in Order \n",
                                style: context.regular(fSize: 16),
                                children: [
                                  TextSpan(
                                    text: "Page to",
                                    style: context.regular(fSize: 16),
                                  ),
                                  TextSpan(
                                    text: " complete",
                                    style: context.regular(
                                      fSize: 16,
                                      color: ColorConstant.primaryMainColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " payment",
                                    style: context.regular(fSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          20.boxHeight,
                          CustomElevatedButton(
                            btnLabel: "Go to Order Page",
                            fSize: 16,
                            onPressedFun: () {
                              context.read<OrderHistoryBloc>().getList();
                              NavigationService.instance
                                  .pushNamedAndRemoveUntil(AppRoute.home);
                              context.read<BottomNavCubit>().navIndexChange(
                                AppNavTab.order,
                              );
                            },
                            elevation: 0,
                          ),
                          Center(
                            child: TextButton(
                              onPressed: () {
                                NavigationService.instance
                                    .pushNamedAndRemoveUntil(AppRoute.home);
                              },
                              child: Text(
                                "Back to Home",
                                style: context.light(
                                  fSize: 16,
                                  color: ColorConstant.primaryMainColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          );
  }

  Widget labelText({required String label, required BuildContext context}) {
    return Text.rich(
      TextSpan(
        text: label,
        style: context.medium(fSize: 14),
        children: [
          TextSpan(
            text: " *",
            style: TextStyle(color: Colors.red, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required String label,
    required String value,
    required BuildContext context,
    Widget? copyIcon,
    Widget? prefixIcon,
  }) {
    return Padding(
      padding: [4, 0].symmetricPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                label,
                maxLines: 1,
                style: context.regular(
                  fSize: 16,
                  color: ColorConstant.greyColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Flexible(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                prefixIcon ?? SizedBox.shrink(),
                Text(
                  value,
                  style: context.regular(fSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                copyIcon ?? SizedBox.shrink(),
              ],
            ),
          ),
        ],
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

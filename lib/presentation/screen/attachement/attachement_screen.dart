import 'package:b2b_freshmore/base_architecture/domain/model/attachement_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/order_history_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/payment_model.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_state.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/attachement_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/order_history_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/payment_bloc.dart';
import 'package:b2b_freshmore/injection_container.dart' as ic;
import 'package:b2b_freshmore/presentation/global/app_bar_widget.dart';
import 'package:b2b_freshmore/presentation/global/app_theme.dart';
import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/custom_button.dart';
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

class AttachmentScreen extends StatefulWidget {
  final OrderHistoryModel model;

  const AttachmentScreen({super.key, required this.model});

  @override
  State<AttachmentScreen> createState() => _AttachmentScreenState();
}

class _AttachmentScreenState extends State<AttachmentScreen> {
  AttachementModel? model;
  @override
  void initState() {
    context.read<PaymentBloc>().getPaymentList();
    model = AttachementModel();
    model!.id = widget.model.id ?? 0;
    super.initState();
  }

  @override
  void dispose() {
    model = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: "Submit Attachment", context: context),
      body: BlocProvider(
        create: (context) => ic.getIt.call<AttachementBloc>(),
        child: Builder(
          builder: (context) {
            return BlocListener<AttachementBloc, ApiState>(
              listener: (context, state) {
                if (state is ApiLoading) {
                  context.showLoading();
                }
                if (state is ApiSuccess<AttachementModel>) {
                  context.hideLoading();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.only(bottom: 50, left: 16, right: 16),
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
                      duration: const Duration(seconds: 2),
                    ),
                  );
                  context.read<OrderHistoryBloc>().getList();
                  NavigationService.instance.goBack();
                }
                if (state is ApiFailure) {
                  context.showNoticeBox(
                    titleText: "Attachment",
                    contentText: state.message,
                  );
                }
              },
              child: BlocBuilder<PaymentBloc, ApiState>(
                builder: (context, state) {
                  PaymentModel? paymentModel;

                  if (state is ApiSuccess<List<PaymentModel>>) {
                    final list = state.data;
                    paymentModel = list.firstWhere(
                      (element) => element.name == widget.model.paymentMethod,
                      orElse: () => PaymentModel(),
                    );
                  }
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: ColorConstant.whiteColor,
                    ),
                    margin: [20, 16].symmetricPadding,
                    padding: 10.allSpacing,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        10.boxHeight,
                        ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(15),
                          child: Center(
                            child: Container(
                              width: 64.fSize,
                              height: 64.fSize,
                              color: ColorConstant.borderStoke,
                              child: CachedNetworkImage(
                                cacheManager: GetIt.I<CacheManager>(),
                                imageUrl: paymentModel?.logoUrl ?? "",
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                                cacheKey: (paymentModel?.logoUrl ?? "")
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
                        ),
                        18.boxHeight,
                        _buildInfoRow(
                          context: context,
                          value: paymentModel?.trasferAccountName ?? "",
                          label: "Transfer Account Name :",
                        ),
                        _buildInfoRow(
                          context: context,
                          value: "${paymentModel?.trasferAccountNo ?? ""} ",
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
                                    text: paymentModel?.trasferAccountNo ?? "",
                                  ),
                                ).then((_) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        " copied to clipboard ${paymentModel?.trasferAccountNo ?? ""}",
                                      ),
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
                          value: "${widget.model.orderNo ?? 0}",
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
                            if (state is ApiSuccess) {
                              return CustomElevatedButton(
                                fSize: 16,
                                elevation: 0,
                                btnLabel:
                                    "Uploaded success, do you wanna upload again?",
                                onPressedFun: () {
                                  context
                                      .read<AttachementBloc>()
                                      .uploadAttachement(model!);
                                },
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
                                    titleColor: ColorConstant.primaryMainColor,
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
                        10.boxHeight,
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
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
}

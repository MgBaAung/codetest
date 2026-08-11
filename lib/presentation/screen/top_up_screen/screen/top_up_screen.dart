import 'dart:io';
import 'package:b2b_freshmore/base_architecture/domain/model/topup_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/wallet_payment_model.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_state.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/top_up_history_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/wallet_request_bloc.dart';
import 'package:b2b_freshmore/presentation/global/app_bar_widget.dart';
import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/custom_button.dart';
import 'package:b2b_freshmore/presentation/global/custom_text_field.dart';
import 'package:b2b_freshmore/presentation/global/drop_down_text_input.dart';
import 'package:b2b_freshmore/presentation/global/extension/dialog_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/text_extension.dart';
import 'package:b2b_freshmore/presentation/global/formatter/text_input_formatter.dart';
import 'package:b2b_freshmore/presentation/screen/wallet/component/choose_file_widget.dart';
import 'package:b2b_freshmore/presentation/screen/wallet/component/transfer_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopUpScreen extends StatefulWidget {
  const TopUpScreen({super.key});

  @override
  State<TopUpScreen> createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  final _paymentController = TextEditingController();
  final _remarkController = TextEditingController();
  final _amountController = TextEditingController();
  final _chooseController = TextEditingController();

  final ValueNotifier<WalletPaymentDataModel?> _selectPaymentNoti =
      ValueNotifier<WalletPaymentDataModel?>(null);

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _isConfirmed = false;
  File? file;
  TopupModel? model = TopupModel(id: 0);
  String? chooseKey = "Other";

  @override
  void dispose() {
    model = null;
    chooseKey = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: "Top Up", context: context),
      body: BlocListener<WalletRequestBloc, ApiState>(
        listener: (context, state) {
          if (state is ApiLoading) {
            context.showLoading();
          }
          if (state is ApiSuccess<TopupModel>) {
            context.read<TopUpHistoryBloc>().getList(refresh: true);
            context.hideLoading();
            context.showNoticeBox(
              titleColor: ColorConstant.primaryMainColor,
              titleText: "Top up Request Successfully",
              contentText: "You created top up request.",

              onPress: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            );
          }
          if (state is ApiFailure) {
            context.hideLoading();
            context.showNoticeBox(
              titleColor: ColorConstant.secondaryColor,
              titleText: "Top up Request Failed",
              contentText: state.message,
            );
          }
        },
        child: Container(
          padding: 10.allSpacing,
          margin: EdgeInsets.only(left: 16, right: 16, bottom: 10, top: 10),
          decoration: BoxDecoration(
            color: ColorConstant.whiteColor,
            border: Border.all(color: ColorConstant.borderStoke),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  labelText("Choose Top up Method"),
                  WalletDropDown(
                    controller: _paymentController,
                    hintText: "Select top up method",
                    callBack: (value) {
                      _selectPaymentNoti.value = value;
                      model?.payment = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select payment';
                      }
                      return null;
                    },
                  ),

                  10.boxHeight,
                  ValueListenableBuilder(
                    valueListenable: _selectPaymentNoti,
                    builder: (context, value, child) {
                      return value == null
                          ? SizedBox.shrink()
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TransferTextWidget(
                                  name: "Transfer Account Name        ",
                                  value: value.trasferAccountName ?? "",
                                ),
                                TransferTextWidget(
                                  name: "Transfer Account Number    ",
                                  value: value.trasferAccountNo ?? "",
                                  isNumber: true,
                                ),
                              ],
                            );
                    },
                  ),
                  10.boxHeight,
                  labelText("Choose Amount"),
                  AmountDropDown(
                    controller: _chooseController,
                    hintText: "Select amount",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select amount';
                      }
                      return null;
                    },
                    callBack: (value) {
                      setState(() {
                        _chooseController.text = (value ?? "").split(" ").first;
                        model!.amount = _chooseController.text.replaceAll(
                          ',',
                          '',
                        );
                      });
                    },
                  ),
                  10.boxHeight,
                  chooseKey == _chooseController.text
                      ? labelText("Amount")
                      : SizedBox.shrink(),
                  chooseKey == _chooseController.text
                      ? CustomTextFormField(
                          textEditingController: _amountController,
                          inputType: TextInputType.number,
                          hintText: "Enter Amount",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter amount';
                            }
                            return null;
                          },
                          onChangedFunction: (value) {
                            model!.amount = value?.replaceAll(',', '');
                          },
                          inputFormatter: [
                            LengthLimitingTextInputFormatter(24),
                            FilteringTextInputFormatter.digitsOnly,
                            ThousandsFormatter(),
                          ],
                        )
                      : SizedBox.shrink(),

                  10.boxHeight,
                  labelText("Remark"),
                  CustomTextFormField(
                    textEditingController: _remarkController,
                    hintText: "Enter remark",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter remark';
                      }
                      return null;
                    },
                  ),

                  10.boxHeight,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      labelText("Attachement File"),
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
                      file = fil;
                      model!.attachment = fil;
                    },
                  ),
                  12.boxHeight,
                  Row(
                    children: [
                      Checkbox(
                        value: _isConfirmed,
                        onChanged: (v) => setState(() => _isConfirmed = v!),
                      ),
                      checkText(),
                    ],
                  ),
                  10.boxHeight,
                  SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                      elevation: _isConfirmed ? null : 0,
                      onPressedFun: _isConfirmed
                          ? () {
                              if (_formkey.currentState!.validate() &&
                                  file != null) {
                                model!.remark = _remarkController.text;
                                context.read<WalletRequestBloc>().uploadRequest(
                                  model: model!,
                                );
                              } else {
                                if (file == null) {
                                  context.showNoticeBox(
                                    titleText: "File",
                                    titleColor: ColorConstant.primaryMainColor,
                                    contentText: "Required File",
                                  );
                                }
                              }
                            }
                          : () {},

                      btnLabel: "Request Top up",
                      fSize: 16,
                      bgColor: _isConfirmed
                          ? ColorConstant.primaryMainColor
                          : Colors.green.shade100,
                    ),
                  ),
                  20.boxHeight,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget checkText() {
    return Text.rich(
      TextSpan(
        text: 'Are you sure you want to ',
        style: context.medium(fSize: 14),
        children: <TextSpan>[
          TextSpan(
            text: 'top up',
            style: context.medium(
              fSize: 14,
              color: ColorConstant.primaryMainColor,
            ),
          ),
          TextSpan(text: '?', style: context.medium(fSize: 14)),
        ],
      ),
    );
  }

  Widget labelText(String label) {
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
}

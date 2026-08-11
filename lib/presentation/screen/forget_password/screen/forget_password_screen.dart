import 'package:b2b_freshmore/base_architecture/domain/model/forget_pwd_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/level_model.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_state.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/forget_pwd_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/level_bloc.dart';
import 'package:b2b_freshmore/injection_container.dart' as ic;
import 'package:b2b_freshmore/presentation/global/app_theme.dart';
import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/custom_button.dart';
import 'package:b2b_freshmore/presentation/global/custom_text_field.dart';
import 'package:b2b_freshmore/presentation/global/drop_down_text_input.dart';
import 'package:b2b_freshmore/presentation/global/extension/dialog_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/text_extension.dart';
import 'package:b2b_freshmore/presentation/global/formatter/text_input_formatter.dart';
import 'package:b2b_freshmore/presentation/global/generate/locale_key.g.dart';
import 'package:b2b_freshmore/presentation/global/navigation_service.dart';
import 'package:b2b_freshmore/presentation/global/size_constant.dart';
import 'package:b2b_freshmore/presentation/screen/forget_password/component/alert_password_error.dart';
import 'package:b2b_freshmore/presentation/screen/forget_password/component/alert_password_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late TextEditingController _idController;
  late TextEditingController _srController;
  late TextEditingController _roleController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: ColorConstant.backgroundColor),
    );

    _idController = TextEditingController();
    _srController = TextEditingController();
    _roleController = TextEditingController();
    super.initState();
  }

  Users? user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ic.getIt.call<ForgetPwdBloc>(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: MultiBlocListener(
              listeners: [
                BlocListener<LevelBloc, ApiState>(
                  listener: (context, state) {
                    if (state is ApiLoading) {
                      context.showLoading();
                    } else {
                      // context.hideLoading();
                      context.hideLoading();
                    }

                    if (state is ApiFailure) {
                      context.showNoticeBox(
                        titleText: "Level",
                        contentText: state.message,
                      );
                    }
                  },
                ),
                BlocListener<ForgetPwdBloc, ApiState>(
                  listener: (context, state) {
                    if (state is ApiLoading) {
                      context.showLoading();
                    } else {
                      context.hideLoading();
                    }
                  },
                ),
              ],
              child: Stack(
                children: [
                  Center(
                    child: BlocBuilder<ForgetPwdBloc, ApiState>(
                      builder: (context, state) {
                        if (state is ApiSuccess<ForgetPwdModel>) {
                          return AlertPasswordWidget();
                        }
                        if (state is ApiFailure) {
                          return AlertPasswordError(message: state.message);
                        }
                        return Form(
                          key: _formKey,
                          child: Padding(
                            padding: [10, 10].symmetricPadding,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  logoWidget(),
                                  30.boxHeight,
                                  textWidget("Forgot Password"),
                                  30.boxHeight,
                                  labelText("Account ID"),
                                  SizeConstant.s2.boxHeight,
                                  CustomTextFormField(
                                    inputType: TextInputType.number,
                                    textEditingController: _idController,
                                    hintText: LocaleKey.lblOwnerId.tr(),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please Enter ID!";
                                      }

                                      return null;
                                    },
                                    onChangedFunction: (value) {
                                      if (_idController.text.length >= 24) {
                                        final String cleanId = _idController
                                            .text
                                            .replaceAll(' ', '');
                                        context.read<LevelBloc>().getLevel(
                                          cleanId,
                                        );
                                      }
                                    },
                                    inputFormatter: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      GroupingFormatter(),
                                      LengthLimitingTextInputFormatter(24),
                                    ],
                                  ),
                                  SizeConstant.s4.boxHeight,

                                  labelText("User ID"),
                                  SizeConstant.s2.boxHeight,
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        width: 151.fSize,
                                        child: ShiftDropDown(
                                          controller: _roleController,
                                          hintText: "Select role",
                                          callBack: (value) {
                                            user = value;
                                            _roleController.text =
                                                'Level ${user?.level ?? ""}';
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Select role!';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      10.boxWidth,
                                      Expanded(
                                        child: CustomTextFormField(
                                          inputType: TextInputType.number,
                                          textEditingController: _srController,
                                          hintText: "Enter your serial number",
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Please enter serial number!";
                                            }
                                            if (value.length != 5) {
                                              return "ID must be exactly 4 digits!";
                                            }

                                            return null;
                                          },
                                          inputFormatter: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(5),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizeConstant.s5.boxHeight,
                                  SizedBox(
                                    width: double.infinity,
                                    child: CustomElevatedButton(
                                      fSize: 16,
                                      btnLabel: "Submit",
                                      onPressedFun: () {
                                        if (_formKey.currentState!.validate()) {
                                          final String cleanId = _idController
                                              .text
                                              .replaceAll(' ', '');
                                          var code =
                                              "${user?.level}${_srController.text}";

                                          context.read<ForgetPwdBloc>().forget(
                                            id: cleanId,
                                            level: code,
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 40,
                    child: IconButton(
                      onPressed: () {
                        NavigationService.instance.goBack();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: SizeConstant.s4.fSize,
                        color: ColorConstant.primaryMainColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget labelText(String label) {
    return Text(label, style: context.regular(fSize: 16));
  }

  Widget logoWidget() {
    return Align(
      alignment: Alignment.center,
      child: Image.asset(
        width: 178.75.fSize,
        height: 80.fSize,
        'assets/images/icons/logo.png',
      ),
    );
  }

  Widget textWidget(String name) {
    return Align(
      alignment: Alignment.center,
      child: Text(name, style: context.semibold(fSize: 23)),
    );
  }
}

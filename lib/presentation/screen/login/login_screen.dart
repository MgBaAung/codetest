import 'package:b2b_freshmore/base_architecture/domain/model/level_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/user_model.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_state.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/auth_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/category_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/level_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/top_up_history_bloc.dart';
import 'package:b2b_freshmore/presentation/global/app_route_constant.dart';
import 'package:b2b_freshmore/presentation/global/app_theme.dart';
import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/custom_button.dart';
import 'package:b2b_freshmore/presentation/global/custom_text_field.dart';
import 'package:b2b_freshmore/presentation/global/drop_down_text_input.dart';
import 'package:b2b_freshmore/presentation/global/enumeration.dart';
import 'package:b2b_freshmore/presentation/global/extension/dialog_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/text_extension.dart';
import 'package:b2b_freshmore/presentation/global/formatter/text_input_formatter.dart';
import 'package:b2b_freshmore/presentation/global/generate/locale_key.g.dart';
import 'package:b2b_freshmore/presentation/global/navigation_service.dart';
import 'package:b2b_freshmore/presentation/global/size_constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  late TextEditingController _idController;
  late TextEditingController _pswController;
  late TextEditingController _srController;
  late TextEditingController _roleController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _visible = true;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: ColorConstant.backgroundColor,
        systemNavigationBarContrastEnforced: true,
        statusBarColor: ColorConstant.backgroundColor,
      ),
    );

    _idController = TextEditingController();
    _pswController = TextEditingController();
    _srController = TextEditingController();
    _roleController = TextEditingController();
    super.initState();
  }

  Users? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<LevelBloc, ApiState>(
            listener: (context, state) {
              if (state is ApiLoading) {
                context.showLoading();
              }

              if (state is ApiFailure) {
                context.hideLoading();
                context.showNoticeBox(
                  titleText: "Level",
                  contentText: state.message,
                );
              }

              if (state is ApiSuccess<LevelModel>) {
                context.hideLoading();
              }
            },
          ),
          BlocListener<AuthBloc, ApiState>(
            listener: (context, state) {
              if (state is ApiLoading) {
                context.showLoading();
              }

              if (state is ApiFailure) {
                context.hideLoading();
                if (!state.message.contains(NoError.cache.name) &&
                    !state.message.contains(NoError.endpoint.name) &&
                    !state.message.contains(NoError.delete.name) &&
                    !state.message.contains(NoError.parsing.name)) {
                  context.showNoticeBox(
                    titleText: "Login ",
                    contentText: state.message,
                  );
                }
              }

              if (state is ApiSuccess<UserModel>) {
                context.hideLoading();
                if (state.data.accessToken != null) {
                  context.read<TopUpHistoryBloc>().getList(refresh: true);
                  context.read<CategoryBloc>().getCategoryList();
                  NavigationService.instance.pushNamedAndRemoveUntil(
                    AppRoute.home,
                  );
                }
              }
            },
          ),
        ],
        child: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: [10, 10].symmetricPadding,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        width: 178.75.fSize,
                        height: 80.fSize,
                        'assets/images/icons/logo.png',
                      ),
                    ),
                    30.boxHeight,
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "B2B Account Login",
                        style: context.semibold(fSize: 23),
                      ),
                    ),
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
                          final String cleanId = _idController.text.replaceAll(
                            ' ',
                            '',
                          );
                          context.read<LevelBloc>().getLevel(cleanId);
                        }
                      },
                      submitFunction: (value) {
                        context.read<LevelBloc>().getLevel(
                          _idController.text.replaceAll(' ', ''),
                        );
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
                          child: ConstrainedBox(
                            constraints: BoxConstraints(minHeight: 52),
                            child: ShiftDropDown(
                              controller: _roleController,
                              hintText: "Select role",
                              callBack: (value) {
                                user = value;
                                _roleController.text =
                                    'Level ${user?.level ?? ""}';
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Select role!';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        10.boxWidth,
                        Expanded(
                          child: CustomTextFormField(
                            inputType: TextInputType.number,
                            textEditingController: _srController,
                            hintText: "Enter your serial number",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter serial number!";
                              }
                              if (value.length != 5) {
                                return "ID must be exactly 4 digits!";
                              }

                              return null;
                            },
                            inputFormatter: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(5),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizeConstant.s4.boxHeight,

                    labelText("Password"),
                    SizeConstant.s2.boxHeight,
                    CustomTextFormField(
                      textEditingController: _pswController,
                      suffixIcon: InkWell(
                        onTap: () => setState(() {
                          _visible = !_visible;
                        }),
                        child: Icon(
                          size: 24.fSize,
                          _visible ? LucideIcons.eyeOff : LucideIcons.eye,
                          color: ColorConstant.primaryMainColor,
                        ),
                      ),
                      hintText: LocaleKey.lblPassword.tr(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Password!";
                        }

                        return null;
                      },
                      obscureText: _visible,
                    ),
                    SizeConstant.s3.boxHeight,
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          NavigationService.instance.pushNamed(AppRoute.forget);
                        },
                        child: Text(
                          "Forgot password?",
                          style: context
                              .regular(
                                fSize: 16,
                                color: ColorConstant.primaryMainColor,
                              )
                              .copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: ColorConstant.primaryMainColor,
                              ),
                        ),
                      ),
                    ),
                    SizeConstant.s4.boxHeight,
                    SizedBox(
                      width: double.infinity,
                      child: CustomElevatedButton(
                        fSize: 16,
                        btnLabel: LocaleKey.btnLogin.tr(),
                        onPressedFun: () {
                          if (_formKey.currentState!.validate()) {
                            final String cleanId = _idController.text
                                .replaceAll(' ', '');
                            var code = "${user?.level}${_srController.text}";

                            context.read<AuthBloc>().login(
                              id: cleanId,
                              password: _pswController.text,
                              code: code,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget labelText(String label) {
    return Text(label, style: context.regular(fSize: 16));
  }
}

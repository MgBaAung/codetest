import 'package:b2b_freshmore/base_architecture/domain/model/password_model.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_state.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/password_bloc.dart';
import 'package:b2b_freshmore/injection_container.dart';
import 'package:b2b_freshmore/presentation/global/app_bar_widget.dart';
import 'package:b2b_freshmore/presentation/global/app_route_constant.dart';
import 'package:b2b_freshmore/presentation/global/app_theme.dart';
import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/custom_button.dart';
import 'package:b2b_freshmore/presentation/global/custom_text_field.dart';
import 'package:b2b_freshmore/presentation/global/extension/dialog_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/text_extension.dart';
import 'package:b2b_freshmore/presentation/global/navigation_service.dart';
import 'package:b2b_freshmore/presentation/global/size_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  bool _currentVisible = true;

  late TextEditingController _pswController;
  late TextEditingController _newPwdController;
  late TextEditingController _comfirmController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late PasswordBloc _bloc;
  Color minColor = Colors.grey;
  Color upperColor = Colors.grey;
  Color lowerColor = Colors.grey;
  Color charColor = Colors.grey;
  Color numColor = Colors.grey;

  @override
  void initState() {
    _pswController = TextEditingController();
    _newPwdController = TextEditingController();
    _comfirmController = TextEditingController();

    _newPwdController.addListener(() => setState(() {}));

    super.initState();
    _bloc = getIt<PasswordBloc>();
  }

  bool _hasMinLength(String v) {
    bool validate = v.length >= 8;
    if (validate) {
      minColor = ColorConstant.primaryMainColor;
    } else {
      minColor = ColorConstant.secondaryColor;
    }
    return validate;
  }

  bool _hasUppercase(String v) {
    var validate = v.contains(RegExp(r'[A-Z]'));
    if (validate) {
      upperColor = ColorConstant.primaryMainColor;
    } else {
      upperColor = ColorConstant.secondaryColor;
    }
    return validate;
  }

  bool _hasLowercase(String v) {
    var validate = v.contains(RegExp(r'[a-z]'));
    if (validate) {
      lowerColor = ColorConstant.primaryMainColor;
    } else {
      lowerColor = ColorConstant.secondaryColor;
    }
    return validate;
  }

  bool _hasSpecial(String v) {
    var validate = v.contains(RegExp(r'[@!#%^&*]'));
    if (validate) {
      charColor = ColorConstant.primaryMainColor;
    } else {
      charColor = ColorConstant.secondaryColor;
    }
    return validate;
  }

  bool _hasNumber(String v) {
    {
      var validate = v.contains(RegExp(r'[0-9]'));
      if (validate) {
        numColor = ColorConstant.primaryMainColor;
      } else {
        numColor = ColorConstant.secondaryColor;
      }
      return validate;
    }
  }

  @override
  Widget build(BuildContext context) {
    String newPassword = _newPwdController.text;

    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),
      appBar: customAppbar(title: "Change Password", context: context),
      body: BlocListener<PasswordBloc, ApiState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is ApiLoading) context.showLoading();
          if (state is ApiSuccess<PasswordModel>) {
            context.hideLoading();
            reset();
            context.showNoticeBox(
              titleText: "Success",
              contentText: "Password changed.",
              actions: [
                TextButton(
                  onPressed: () {
                    NavigationService.instance.pushNamedAndRemoveUntil(
                      AppRoute.loginPage,
                    );
                  },
                  child: Text("Ok"),
                ),
              ],
            );
          }
          if (state is ApiFailure) {
            context.hideLoading();
            context.showNoticeBox(
              titleText: "Error",
              contentText: state.message,
            );
          }
        },
        child: Padding(
          padding: [0, 16].symmetricPadding,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.boxHeight,
                  labelText("Current Password"),
                  SizeConstant.s2.boxHeight,
                  _buildTextField(
                    _pswController,
                    "Enter current password",
                    _currentVisible,
                    () => setState(() => _currentVisible = !_currentVisible),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter your old password";
                      }
                      return null;
                    },
                  ),

                  SizeConstant.s4.boxHeight,
                  labelText("New Password"),
                  SizeConstant.s2.boxHeight,
                  _buildTextField(
                    _newPwdController,
                    "Enter new password",
                    _currentVisible,
                    () => setState(() => _currentVisible = !_currentVisible),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter new password";
                      }
                      if (!_hasMinLength(value)) {
                        return "Password must be at least 8 characters";
                      }
                      if (!_hasUppercase(value)) {
                        return "Need at least one uppercase letter";
                      }
                      if (!_hasLowercase(value)) {
                        return "Need at least one lowercase letter";
                      }
                      if (!_hasNumber(value)) return "Need at least one number";
                      if (!_hasSpecial(value)) {
                        return "Need at least one special character (@!#%^&*)";
                      }

                      return null;
                    },
                  ),

                  SizeConstant.s2.boxHeight,
                  Text(
                    "Set up a strong password at least",
                    style: context.medium(
                      fSize: 13,
                      color: ColorConstant.textColor,
                    ),
                  ),
                  SizeConstant.s2.boxHeight,

                  _validationRow(
                    "Minimum 8 numbers in password",
                    _hasMinLength(newPassword),
                    minColor,
                  ),
                  _validationRow(
                    "Uppercase alphabet",
                    _hasUppercase(newPassword),
                    upperColor,
                  ),
                  _validationRow(
                    "Lowercase alphabet",
                    _hasLowercase(newPassword),
                    lowerColor,
                  ),
                  _validationRow(
                    "Character (@!#%^&*)",
                    _hasSpecial(newPassword),
                    charColor,
                  ),
                  _validationRow(
                    "Number (1234567890)",
                    _hasNumber(newPassword),
                    numColor,
                  ),

                  SizeConstant.s4.boxHeight,
                  labelText("Confirm Password"),
                  SizeConstant.s2.boxHeight,
                  _buildTextField(
                    _comfirmController,
                    "Enter confirm password",
                    _currentVisible,
                    () {
                      setState(() => _currentVisible = !_currentVisible);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please confirm your password";
                      }
                      if (value != _newPwdController.text) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                  ),

                  SizeConstant.s4.boxHeight,
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          child: CustomElevatedButton(
                            btnLabel: "Clear All",
                            bgColor: ColorConstant.whiteColor,
                            btnTextColor: ColorConstant.textColor,
                            onPressedFun: reset,
                            fSize: 14,
                            elevation: 0,
                          ),
                        ),
                      ),
                      12.boxWidth,
                      Expanded(
                        child: CustomElevatedButton(
                          btnLabel: "Change Password",
                          bgColor: ColorConstant.primaryMainColor,
                          elevation: 0,
                          onPressedFun: () {
                            if (_formKey.currentState!.validate() &
                                _isPasswordValid) {
                              _bloc.change(
                                news: _newPwdController.text,
                                old: _pswController.text,
                              );
                            }
                          },
                          fSize: 14,
                        ),
                      ),
                    ],
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

  Widget _buildTextField(
    TextEditingController controller,
    String hint,
    bool obscure,
    VoidCallback toggle, {
    String? Function(String?)? validator,
  }) {
    return CustomTextFormField(
      textEditingController: controller,
      obscureText: obscure,
      hintText: hint,
      suffixIcon: IconButton(
        icon: Icon(
          obscure ? LucideIcons.eyeOff : LucideIcons.eye,
          color: Colors.grey,
          size: 20.fSize,
        ),
        onPressed: toggle,
      ),
      validator: validator,
    );
  }

  Widget _validationRow(String text, bool isValid, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(
            isValid ? Icons.check_circle : Icons.check_circle_outline,
            size: 16.fSize,
            color: color,
          ),
          8.boxWidth,
          Text(
            text,
            style: context.regular(
              fSize: 12,
              color: isValid ? Colors.black87 : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget labelText(String label) {
    return Text.rich(
      TextSpan(
        text: label,
        style: context.bold(fSize: 14),
        children: [
          TextSpan(
            text: " *",
            style: TextStyle(color: Colors.red, fontSize: 16),
          ),
        ],
      ),
    );
  }

  void reset() {
    _formKey.currentState?.reset();
    _pswController.clear();
    _newPwdController.clear();
    _comfirmController.clear();
    setState(() {});
  }

  bool get _isPasswordValid {
    final v = _newPwdController.text;
    return _hasMinLength(v) &&
        _hasUppercase(v) &&
        _hasLowercase(v) &&
        _hasSpecial(v) &&
        _hasNumber(v);
  }
}

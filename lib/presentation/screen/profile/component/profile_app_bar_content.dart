import 'package:b2b_freshmore/base_architecture/data/local_datasource/token_manager.dart';
import 'package:b2b_freshmore/base_architecture/state_management/cubit/bottom_nav_cubit.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/auth_bloc.dart';
import 'package:b2b_freshmore/presentation/global/app_route_constant.dart';
import 'package:b2b_freshmore/presentation/global/app_theme.dart';
import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/custom_button.dart';
import 'package:b2b_freshmore/presentation/global/enumeration.dart';
import 'package:b2b_freshmore/presentation/global/extension/dialog_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/text_extension.dart';
import 'package:b2b_freshmore/presentation/global/generate/locale_key.g.dart';
import 'package:b2b_freshmore/presentation/global/key_util.dart';
import 'package:b2b_freshmore/presentation/global/navigation_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ProfileAppBarContent extends StatelessWidget {
  const ProfileAppBarContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Profile", style: context.bold(fSize: 23)),
        GestureDetector(
          onTap: () {
            context.showNoticeBox(
              titleText: LocaleKey.lblLogout.tr(),
              contentText: LocaleKey.lblLogoutConfirmMsg.tr(),
              actions: [
                Container(
                  height: 46.v,
                  padding: 5.rightSpacing,
                  child: CustomElevatedButton(
                    fSize: 16,
                    elevation: 0,
                    bgColor: ColorConstant.whiteColor,
                    borderColor: Color(0xFFE8E8E8),
                    btnTextColor: ColorConstant.blcakColor,
                    btnLabel: LocaleKey.lblCancel.tr(),
                    onPressedFun: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Container(
                  height: 46.v,
                  padding: 5.leftSpacing,
                  child: CustomElevatedButton(
                    fSize: 16,
                    elevation: 0,
                    bgColor: ColorConstant.secondaryColor,
                    btnLabel: LocaleKey.btnLogout.tr(),
                    onPressedFun: () {
                      tap(context);
                    },
                  ),
                ),
              ],
            );
          },
          child: Container(
            height: 40.fSize,
            width: 40.fSize,
            padding: [10, 10].symmetricPadding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorConstant.secondaryColor,
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: Color(0x2121211A).withValues(alpha: 0.1),
                ),
              ],
            ),
            child: Icon(
              size: 20.fSize,
              LucideIcons.logOut,
              color: ColorConstant.whiteColor,
            ),
          ),
        ),
      ],
    );
  }

  void tap(BuildContext context) {
    context.read<AuthBloc>().clear();
    var tokenManager = context.read<TokenManager>();
    tokenManager.deleteToken(kAccess);
    tokenManager.deleteToken(kRefresh);
    context.read<BottomNavCubit>().navIndexChange(AppNavTab.home);
    NavigationService.instance.pushNamedAndRemoveUntil(AppRoute.loginPage);
 
  }
}

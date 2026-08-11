import 'package:b2b_freshmore/base_architecture/domain/model/user_model.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_state.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/auth_bloc.dart';
import 'package:b2b_freshmore/presentation/global/app_route_constant.dart';
import 'package:b2b_freshmore/presentation/global/app_theme.dart';
import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/custom_button.dart';
import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/string_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/text_extension.dart';
import 'package:b2b_freshmore/presentation/global/navigation_service.dart';
import 'package:b2b_freshmore/presentation/global/size_constant.dart';
import 'package:b2b_freshmore/presentation/screen/profile/component/profile_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, ApiState>(
      listener: (context, state) {
        if (state is ApiSuccess<UserModel>) {
          _refreshController.refreshCompleted();
        }
      },
      child: BlocBuilder<AuthBloc, ApiState>(
        builder: (context, state) {
          UserModel? userModel;
          if (state is ApiSuccess<UserModel>) {
            userModel = state.data;
          }
          return SmartRefresher(
            enablePullUp: false,
            enablePullDown: true,
            controller: _refreshController,
            onRefresh: () {
              context.read<AuthBloc>().getProfile();
            },
            child: Padding(
              padding: [0, 16].symmetricPadding,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.boxHeight,
                    Container(
                      padding: 15.allSpacing,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: ColorConstant.whiteColor,
                        borderRadius: BorderRadius.circular(SizeConstant.s2),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            color: Color(0xFF212121).withValues(alpha: 0.1),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 80.fSize,
                            width: 80.fSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorConstant.primaryMainColor,
                            ),
                            child: Center(
                              child: Text(
                                getInitials(userModel?.userName ?? ""),
                                style: context.medium(
                                  fSize: 30,
                                  color: ColorConstant.whiteColor,
                                ),
                              ),
                            ),
                          ),
                          ProfileItem(
                            title: "Name",
                            value: userModel?.userName ?? "-",
                          ),
                          ProfileItem(
                            title: "Account ID",
                            value: userModel?.code ?? "",
                          ),
                          (userModel?.level ?? 0) <= 0
                              ? SizedBox.shrink()
                              : ProfileItem(
                                  title: "Organization Level",
                                  value: "Level ${userModel?.level ?? 0}",
                                ),
                          ProfileItem(
                            title: "Role",
                            value: userModel?.position ?? "-",
                          ),
                          ProfileItem(
                            title: "User ID",
                            value: userModel?.userRole ?? "-",
                          ),

                          ProfileItem(
                            title: "Email",
                            value: (userModel?.email ?? "-").isEmpty
                                ? "-"
                                : userModel?.email ?? "-",
                          ),
                          ProfileItem(
                            title: "Phone Number",
                            value: userModel?.phone ?? "-",
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: 10.topSpacing,
                      child: IconButtonText(
                        title: "Bookmark",
                        prefixIcon: LucideIcons.bookmark,
                        onPressedFun: () {
                          NavigationService.instance.pushNamed(
                            AppRoute.bookMark,
                          );
                        },
                        trailIcon: Icons.arrow_forward_ios,
                      ),
                    ),
                    Padding(
                      padding: [10, 0].symmetricPadding,
                      child: IconButtonText(
                        title: "Change Password",
                        prefixIcon: LucideIcons.lock,
                        onPressedFun: () {
                          NavigationService.instance.pushNamed(
                            AppRoute.password,
                          );
                        },
                        trailIcon: Icons.arrow_forward_ios,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget labelText({required String title}) {
    return Padding(
      padding: SizeConstant.f1.topSpacing,
      child: Text(title, style: context.medium(fSize: 20)),
    );
  }
}

import 'package:b2b_freshmore/base_architecture/state_management/cubit/bottom_nav_cubit.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/amount_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/cart_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/order_history_bloc.dart';
import 'package:b2b_freshmore/presentation/global/app_theme.dart';
import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/custom_app_bar.dart';
import 'package:b2b_freshmore/presentation/global/enumeration.dart';
import 'package:b2b_freshmore/presentation/global/extension/context_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/dialog_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/text_extension.dart';
import 'package:b2b_freshmore/presentation/global/generate/locale_key.g.dart';
import 'package:b2b_freshmore/presentation/global/navigation_service.dart';
import 'package:b2b_freshmore/presentation/global/size_constant.dart';
import 'package:b2b_freshmore/presentation/screen/home/component/home_appbar_content.dart';
import 'package:b2b_freshmore/presentation/screen/home/component/home_body_page.dart';
import 'package:b2b_freshmore/presentation/screen/order_history/component/order_history_appbar.dart';
import 'package:b2b_freshmore/presentation/screen/order_history/screen/order_history_screen.dart';
import 'package:b2b_freshmore/presentation/screen/profile/component/profile_app_bar_content.dart';
import 'package:b2b_freshmore/presentation/screen/profile/screen/profile_screen.dart';
import 'package:b2b_freshmore/presentation/screen/wallet/component/wallet_app_bar.dart';
import 'package:b2b_freshmore/presentation/screen/wallet/screen/wallet_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _orderController = TextEditingController();

  final RefreshController _homeRefresher = RefreshController(
    initialRefresh: false,
  );

  @override
  void initState() {
    context.read<AmountBloc>().getAmountList();
    context.read<OrderHistoryBloc>().getList();
    context.read<CartListBloc>().getCartList();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: ColorConstant.primaryMainColor,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        systemStatusBarContrastEnforced: true,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, AppNavTab>(
      builder: (context, currentIndex) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) async {
            if (didPop) return;

            final bool? exitConfirmed = await context.showNoticeBox<bool>(
              titleText: "Confirmation",
              contentText: "Are you sure you want to exit?",
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text("Cancel", style: context.medium()),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text("Ok", style: context.medium()),
                ),
              ],
            );

            if (exitConfirmed == true) {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            }
          },
          child: Scaffold(
            primary: false,
            appBar: CustomHeaderAppBar(
              index: currentIndex,
              isProfile: currentIndex.isProfile,
              content: appBar(currentIndex),
              showShadow: currentIndex.showShadow,
              secondColor: currentIndex.secondColor,
              appBgColor: currentIndex.appBgColor,
              appBarColor: currentIndex.appBarColor,
            ),
            resizeToAvoidBottomInset: false,
            body: body(currentIndex),
            bottomNavigationBar: BottomAppBar(
              notchMargin: SizeConstant.s2,
              color: ColorConstant.whiteColor,
              height: kBottomNavigationBarHeight + 10,
              padding: context.isMobile
                  ? SizeConstant.s2.topSpacing
                  : SizeConstant.s3.topSpacing,
              elevation: SizeConstant.s1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildNavItem(
                    LucideIcons.house,
                    LocaleKey.lblHome.tr(),
                    AppNavTab.home,
                    currentIndex,
                  ),
                  _buildNavItem(
                    LucideIcons.archive,
                    LocaleKey.lblorder.tr(),
                    AppNavTab.order,
                    currentIndex,
                  ),
                  _buildNavItem(
                    LucideIcons.wallet,
                    "Wallet",
                    AppNavTab.wallet,
                    currentIndex,
                  ),
                  _buildNavItem(
                    LucideIcons.circleUserRound,
                    LocaleKey.lblAcc.tr(),
                    AppNavTab.profile,
                    currentIndex,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget appBar(AppNavTab index) {
    switch (index) {
      case AppNavTab.home:
        return HomeAppbarContent(controller: _controller);
      case AppNavTab.order:
        return OrderHistoryAppbar(controller: _orderController);
      case AppNavTab.profile:
        return ProfileAppBarContent();
      case AppNavTab.wallet:
        return WalletAppBar();
    }
  }

  Widget body(AppNavTab index) {
    switch (index) {
      case AppNavTab.home:
        return HomeBodyPage(
          controller: _controller,
          homeRefresher: _homeRefresher,
        );
      case AppNavTab.order:
        return OrderHistoryScreen(controller: _orderController);
      case AppNavTab.profile:
        return ProfileScreen();
      case AppNavTab.wallet:
        return const WalletScreen();
    }
  }

  Widget _buildNavItem(
    IconData icon,
    String label,
    AppNavTab tab,
    AppNavTab currentTab,
  ) {
    final isSelected = tab == currentTab;
    final color = isSelected ? tab.activeColor : tab.inactiveColor;
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        BuildContext? context =
            NavigationService.instance.navigationKey.currentContext;
        context!.read<BottomNavCubit>().navIndexChange(tab);
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: color, size: 30.fSize),
            Text(
              label,
              style: context.medium(fSize: SizeConstant.f2, color: color),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_state.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/top_up_history_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/wallet_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/wallet_history_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/wallet_payment_bloc.dart';
import 'package:b2b_freshmore/presentation/global/app_route_constant.dart';
import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/custom_button.dart';
import 'package:b2b_freshmore/presentation/global/extension/dialog_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/global/navigation_service.dart';
import 'package:b2b_freshmore/presentation/screen/transaction_history/screen/transaction_history_page.dart';
import 'package:b2b_freshmore/presentation/screen/wallet/component/balance_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    context.read<WalletBloc>().getWallets();
    context.read<WalletPaymentBloc>().getWalletPayment();
    context.read<WalletHistoryBloc>().getList(refresh: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<WalletHistoryBloc, ApiState>(
          listener: (context, state) {
            if (state is ApiFailure) {
              context.showNoticeBox(
                titleText: "Wallet History",
                contentText: state.message,
              );
            }
          },
        ),
        BlocListener<WalletBloc, ApiState>(
          listener: (context, state) {
            if (state is ApiFailure) {
              context.showNoticeBox(
                titleText: "Wallet Balance",
                contentText: state.message,
              );
            }
          },
        ),

        BlocListener<TopUpHistoryBloc, ApiState>(
          listener: (context, state) {
            if (state is ApiLoading) {
              context.showLoading();
            }
            if (state is ApiSuccess) {
              context.hideLoading();
            }
            if (state is ApiFailure) {
              context.hideLoading();
              context.showNoticeBox(
                titleText: "Wallet Method",
                contentText: state.message,
              );
            }
          },
        ),
      ],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BalanceWidget(),
          Container(
            margin: 10.bottomSpacing,
            padding: [0, 16].symmetricPadding,
            width: double.infinity,
            child: CustomElevatedButton(
              radius: 5,
              btnLabel: "Top Up",
              fSize: 16,
              onPressedFun: () {
                NavigationService.instance.pushNamed(AppRoute.topup);
              },
              elevation: 0,
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 16, right: 16, bottom: 10),
              decoration: BoxDecoration(
                color: ColorConstant.whiteColor,
                border: Border.all(color: ColorConstant.borderStoke),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TransactionHistoryPage(),
            ),
          ),
        ],
      ),
    );
  }
}

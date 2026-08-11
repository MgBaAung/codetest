import 'package:b2b_freshmore/base_architecture/domain/model/wallet_history_model.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_state.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/top_up_history_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/wallet_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/wallet_history_bloc.dart';
import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/custom_button.dart';
import 'package:b2b_freshmore/presentation/global/custom_error_widget.dart';
import 'package:b2b_freshmore/presentation/global/extension/dialog_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/screen/transaction_history/component/top_up_item_widget.dart';
import 'package:b2b_freshmore/presentation/screen/transaction_history/component/transaction_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({super.key});

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  ValueNotifier<Transcation> selectLocation = ValueNotifier(Transcation.topup);
  final RefreshController _topupController = RefreshController(
    initialRefresh: false,
  );
  final RefreshController _transitionController = RefreshController(
    initialRefresh: false,
  );

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<WalletHistoryBloc, ApiState>(
          listener: (context, state) {
            if (state is ApiSuccess<List<WalletHistoryDataModel>>) {
              _transitionController.loadComplete();
            }
            if (state is ApiSuccessNoMoreData<List<WalletHistoryDataModel>>) {
              _transitionController.loadNoData();
            }
            if (state is ApiFailure) {
              context.showNoticeBox(
                titleText: "Wallet Transaction",
                contentText: state.message,
              );
            }
          },
        ),
        BlocListener<TopUpHistoryBloc, ApiState>(
          listener: (context, state) {
            if (state is ApiSuccess<List<WalletHistoryDataModel>>) {
              _topupController.loadComplete();
            }
            if (state is ApiSuccessNoMoreData<List<WalletHistoryDataModel>>) {
              _topupController.loadNoData();
            }
            if (state is ApiFailure) {
              context.showNoticeBox(
                titleText: "Topup History",
                contentText: state.message,
              );
            }
          },
        ),
      ],
      child: ValueListenableBuilder(
        valueListenable: selectLocation,
        builder: (context, value, child) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 16,
                  right: 16,
                  left: 16,
                  bottom: 0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: ColorConstant.whiteColor,
                ),
                child: Container(
                  width: double.infinity,
                  padding: [5, 5].symmetricPadding,
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorConstant.borderStoke),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomElevatedButton(
                          elevation: 0,
                          onPressedFun: () {
                            selectLocation.value = Transcation.topup;
                          },
                          btnLabel: "Top Up History",
                          fSize: 14,
                          radius: 4,
                          bgColor: selectLocation.value == Transcation.topup
                              ? ColorConstant.primaryMainColor
                              : Colors.white,
                          btnTextColor:
                              selectLocation.value == Transcation.topup
                              ? ColorConstant.whiteColor
                              : ColorConstant.primaryMainColor,
                        ),
                      ),
                      Expanded(
                        child: CustomElevatedButton(
                          elevation: 0,
                          onPressedFun: () {
                            selectLocation.value = Transcation.transaction;
                          },
                          btnLabel: "Transaction History",
                          fSize: 14,
                          radius: 4,
                          bgColor:
                              selectLocation.value == Transcation.transaction
                              ? ColorConstant.primaryMainColor
                              : Colors.white,
                          btnTextColor:
                              selectLocation.value == Transcation.transaction
                              ? ColorConstant.whiteColor
                              : ColorConstant.primaryMainColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: Container(
                  child: IndexedStack(
                    index: value == Transcation.topup ? 0 : 1,
                    children: [
                      BlocBuilder<TopUpHistoryBloc, ApiState>(
                        builder: (context, state) {
                          if (state
                              is ApiSuccess<List<WalletHistoryDataModel>>) {
                            if (state.data.isEmpty) {
                              return SizedBox.shrink();
                            }
                            return topUp(state.data);
                          }
                          if (state
                              is ApiSuccessNoMoreData<
                                List<WalletHistoryDataModel>
                              >) {
                            return topUp(state.data);
                          }
                          if (state is ApiFailure) {
                            return ApiErrorWidget(
                              onRetry: () {
                                _loadTopup();
                              },
                            );
                          }
                          return SizedBox.shrink();
                        },
                      ),
                      BlocBuilder<WalletHistoryBloc, ApiState>(
                        builder: (context, state) {
                          if (state
                              is ApiSuccess<List<WalletHistoryDataModel>>) {
                            if (state.data.isEmpty) {
                              return SizedBox.shrink();
                            }
                            return transaction(state.data);
                          }
                          if (state
                              is ApiSuccessNoMoreData<
                                List<WalletHistoryDataModel>
                              >) {
                            return transaction(state.data);
                          }
                          if (state is ApiFailure) {
                            return ApiErrorWidget(
                              onRetry: () {
                                _loadTransaction();
                              },
                            );
                          }
                          return SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget transaction(List<WalletHistoryDataModel> list) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      onLoading: () {
        _loadTransaction(append: true);
      },
      onRefresh: () {
        _loadTransaction(append: false);
      },
      controller: _transitionController,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: list.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return 14.boxHeight;
          }
          return TransactionItemWidget(model: list[index - 1]);
        },
      ),
    );
  }

  Widget topUp(List<WalletHistoryDataModel> list) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      onLoading: () {
        _loadTopup(append: true);
      },
      onRefresh: () {
        context.read<WalletBloc>().getWallets();
        _loadTopup(append: false);
      },

      header: WaterDropHeader(),
      controller: _topupController,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: list.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return 14.boxHeight;
          }
          return TopUpItemWidget(model: list[index - 1]);
        },
      ),
    );
  }

  void _loadTopup({bool append = false}) {
    context.read<TopUpHistoryBloc>().getList(shouldAppend: append);
  }

  void _loadTransaction({bool append = false}) {
    context.read<WalletHistoryBloc>().getList(shouldAppend: append);
  }
}

enum Transcation { topup, transaction }

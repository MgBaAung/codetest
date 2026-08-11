import 'package:b2b_freshmore/base_architecture/domain/model/order_history_model.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_state.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/order_history_bloc.dart';
import 'package:b2b_freshmore/presentation/global/custom_error_widget.dart';
import 'package:b2b_freshmore/presentation/global/extension/dialog_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/screen/bookmark/component/book_shimmer.dart';
import 'package:b2b_freshmore/presentation/screen/order_history/component/order_history_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OrderHistoryScreen extends StatefulWidget {
  final TextEditingController controller;
  const OrderHistoryScreen({super.key, required this.controller});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  final RefreshController _controller = RefreshController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderHistoryBloc, ApiState>(
      listener: (context, state) {
        if (state is ApiFailure) {
          context.showNoticeBox(
            titleText: "Order History",
            contentText: state.message,
          );
        }
        if (state is ApiSuccess) {
          _controller.loadComplete();
        }
        if (state is ApiSuccessNoMoreData<List<OrderHistoryModel>>) {
          _controller.refreshCompleted();
          _controller.loadNoData();
        }
      },

      child: BlocBuilder<OrderHistoryBloc, ApiState>(
        builder: (context, state) {
          if (state is ApiLoading) {
            return ListView.separated(
              itemCount: 10,
              itemBuilder: (context, index) {
                return BookMarktemShimmer();
              },
              separatorBuilder: (context, index) {
                return 10.boxHeight;
              },
            );
          }

          if (state is ApiSuccess<List<OrderHistoryModel>>) {
            context.hideLoading();
            final orderList = state.data;

            if (orderList.isEmpty) {
              return SmartRefresher(
                enablePullUp: false,
                enablePullDown: true,
                controller: _controller,
                onRefresh: () {
                  widget.controller.clear();
                  context.read<OrderHistoryBloc>().getList(refresh: true);
                },
                child: const Center(child: Text("No Order History Available")),
              );
            }
            return getList(orderList);
          }
          if (state is ApiSuccessNoMoreData<List<OrderHistoryModel>>) {
            return getList(state.data);
          }
          if (state is ApiFailure) {
            return ApiErrorWidget(
              onRetry: () {
                widget.controller.clear();
                _loadProducts(context: context, refresh: true);
              },
            );
          }
          return SizedBox.fromSize();
        },
      ),
    );
  }

  Widget getList(List<OrderHistoryModel> list) {
    return SmartRefresher(
      controller: _controller,
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      onLoading: () {
        _loadProducts(append: true, context: context);
      },
      onRefresh: () {
        widget.controller.clear();
        context.read<OrderHistoryBloc>().clean();
        _loadProducts(context: context, refresh: true);
      },
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: [0, 16].symmetricPadding,
            sliver: SliverList.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return OrderHistoryItem(model: list[index]);
              },
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }

  void _loadProducts({
    bool append = false,
    bool refresh = false,
    required BuildContext context,
  }) {
    context.read<OrderHistoryBloc>().getList(
      shouldAppend: append,
      refresh: refresh,
    );
  }
}

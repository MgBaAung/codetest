import 'package:b2b_freshmore/base_architecture/domain/model/category_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/sub_category.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_state.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/category_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/product_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/sub_category_bloc.dart';
import 'package:b2b_freshmore/presentation/global/app_route_constant.dart';
import 'package:b2b_freshmore/presentation/global/custom_error_widget.dart';
import 'package:b2b_freshmore/presentation/global/extension/context_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/dialog_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/text_extension.dart';
import 'package:b2b_freshmore/presentation/global/navigation_service.dart';
import 'package:b2b_freshmore/presentation/screen/home/component/category_shimmer.dart';
import 'package:b2b_freshmore/presentation/screen/home/component/home_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeBodyPage extends StatefulWidget {
  final TextEditingController controller;
  final RefreshController homeRefresher;
  const HomeBodyPage({
    super.key,
    required this.controller,
    required this.homeRefresher,
  });

  @override
  State<HomeBodyPage> createState() => _HomeBodyPageState();
}

class _HomeBodyPageState extends State<HomeBodyPage> {
  CategoryData? category;
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CategoryBloc, ApiState>(
          listener: (context, state) {
            if (state is ApiFailure) {
              context.showNoticeBox(
                titleText: "Category List",
                contentText: state.message,
                actions: [
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        NavigationService.instance.pushNamedAndRemoveUntil(
                          AppRoute.loginPage,
                        );
                      },
                      child: Text(
                        "Ok",
                        style: TextStyle().titleSmallStyle(
                          Colors.black,
                          FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            if (state is ApiSuccess) {
              widget.homeRefresher.loadComplete();
            }
            if (state is ApiSuccessNoMoreData<List<CategoryData>>) {
              widget.homeRefresher.refreshCompleted();
              widget.homeRefresher.loadNoData();
            }
          },
        ),

        BlocListener<SubCategoryBloc, ApiState>(
          listener: (context, state) {
            if (state is ApiLoading) {
              context.showLoading();
            }
            if (state is ApiFailure) {
              context.hideLoading();
              context.showNoticeBox(
                titleText: "Getting Products",
                contentText: state.message,
              );
            }
            if (state is ApiSuccess<List<SubCategoryData>>) {
              context.hideLoading();
              NavigationService.instance.pushNamed(
                AppRoute.fruits,
                args: category!.enName,
              );
            }
          },
        ),
      ],
      child: BlocBuilder<CategoryBloc, ApiState>(
        builder: (context, state) {
          if (state is ApiLoading) {
            return const CategoryShimmer();
          }

          if (state is ApiSuccess<List<CategoryData>>) {
            // context.hideLoading();
            final categories = state.data;

            if (categories.isEmpty) {
              return const Center(child: Text("No Categories Available"));
            }

            return getList(categories);
          }

          if (state is ApiSuccessNoMoreData<List<CategoryData>>) {
            return getList(state.data);
          }
          return Center(
            child: ApiErrorWidget(
              errorMessage: "Something went wrong!",
              onRetry: () {
                widget.controller.clear();
                context.read<CategoryBloc>().clean();
                _loadProducts(context: context, refresh: true);
              },
            ),
          );
        },
      ),
    );
  }

  void _loadProducts({
    bool append = false,
    bool refresh = false,
    required BuildContext context,
  }) {
    context.read<CategoryBloc>().getCategoryList(
      shouldAppend: append,
      refresh: refresh,
    );
  }

  Widget getList(List<CategoryData> categories) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      controller: widget.homeRefresher,
      onLoading: () {
        _loadProducts(append: true, context: context);
      },
      onRefresh: () {
        widget.controller.clear();
        context.read<CategoryBloc>().clean();
        _loadProducts(context: context, refresh: true);
      },
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 15)),
          SliverPadding(
            padding: [0, 16].symmetricPadding,
            sliver: SliverGrid.builder(
              itemCount: categories.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: context.isMobile ? 2 : 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 2,
              ),
              itemBuilder: (context, index) {
                return HomeCardItem(
                  onTap: () {
                    category = categories[index];
                    context.read<ProductBloc>().setId(
                      (category!.id ?? 0).toInt(),
                    );
                    context.read<SubCategoryBloc>().getSubCategry(
                      (category!.id ?? 0).toInt(),
                    );
                  },
                  categoryData: categories[index],
                );
              },
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}

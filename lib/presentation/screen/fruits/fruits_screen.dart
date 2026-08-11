import 'package:b2b_freshmore/base_architecture/domain/model/product_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/sub_category.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_state.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/product_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/sub_category_bloc.dart';
import 'package:b2b_freshmore/presentation/global/app_theme.dart';
import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/custom_error_widget.dart';
import 'package:b2b_freshmore/presentation/global/extension/dialog_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/text_extension.dart';
import 'package:b2b_freshmore/presentation/global/image_constant.dart';
import 'package:b2b_freshmore/presentation/global/navigation_service.dart';
import 'package:b2b_freshmore/presentation/global/size_constant.dart';
import 'package:b2b_freshmore/presentation/screen/bookmark/component/book_shimmer.dart';
import 'package:b2b_freshmore/presentation/screen/fruits/component/fruit_button_widget.dart';
import 'package:b2b_freshmore/presentation/screen/fruits/component/fruit_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FruitsScreen extends StatefulWidget {
  final String title;
  const FruitsScreen({super.key, required this.title});

  @override
  State<FruitsScreen> createState() => _FruitsScreenState();
}

class _FruitsScreenState extends State<FruitsScreen> {
  String curBtn = "All";
  final TextEditingController _searchController = TextEditingController();
  int? categoryId;
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  void initState() {
    context.read<ProductBloc>().getProductList(refresh: true);
    super.initState();
  }

  List data = [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ApiState>(
      listener: (context, state) {
        if (state is ApiFailure) {
          context.showNoticeBox(
            titleText: "Product List",
            contentText: state.message,
          );
        }
        if (state is ApiSuccess<List<ProductData>>) {
          if (data.isEmpty) {
            data = state.data;
          }
          _refreshController.loadComplete();
        }
        if (state is ApiSuccessNoMoreData<List<ProductData>>) {
          if (data.isEmpty) {
            data = state.data;
          }
          _refreshController.loadNoData();
        }
      },
      child: BlocBuilder<ProductBloc, ApiState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => NavigationService.instance.goBack(),
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 18,
                  color: ColorConstant.whiteColor,
                ),
              ),
              titleSpacing: 0,
              centerTitle: false,
              title: Text(
                widget.title,
                style: context.semibold(color: Colors.white, fSize: 18),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(140),
                child: Container(
                  color: ColorConstant.backgroundColor,
                  child: Container(
                    margin: 0.bottomSpacing,
                    width: double.infinity,
                    color: ColorConstant.backgroundColor,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: ColorConstant.whiteColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(SizeConstant.s4),
                              bottomRight: Radius.circular(SizeConstant.s4),
                            ),
                          ),
                          height: 80.fSize,
                          padding: [0, 16].symmetricPadding,
                          child: Center(
                            child: TextField(
                              textAlignVertical: TextAlignVertical.center,
                              controller: _searchController,
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: "Search Order",
                                hintStyle: context.regular(
                                  color: ColorConstant.greyColor,
                                  fSize: SizeConstant.f1,
                                ),
                                suffixIcon:
                                    ValueListenableBuilder<TextEditingValue>(
                                      valueListenable: _searchController,
                                      builder: (context, value, child) {
                                        return value.text.isEmpty
                                            ? IconButton(
                                                onPressed: () {
                                                  if (_searchController
                                                      .text
                                                      .isNotEmpty) {
                                                    context
                                                        .read<ProductBloc>()
                                                        .getProductList(
                                                          keywords:
                                                              _searchController
                                                                  .text,
                                                        );
                                                  }
                                                },
                                                icon: Icon(
                                                  LucideIcons.search,
                                                  size: 18.fSize,
                                                  color:
                                                      ColorConstant.greyColor,
                                                ),
                                              )
                                            : IconButton(
                                                onPressed: () {
                                                  curBtn = "All";
                                                  _searchController.clear();
                                                  context
                                                      .read<ProductBloc>()
                                                      .clean();
                                                  context
                                                      .read<ProductBloc>()
                                                      .getProductList();
                                                },
                                                icon: Icon(
                                                  Icons.close,
                                                  size: 18.fSize,
                                                  color:
                                                      ColorConstant.greyColor,
                                                ),
                                              );
                                      },
                                    ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ColorConstant.borderStoke,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    SizeConstant.s2,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ColorConstant.borderStoke,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    SizeConstant.s2,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ColorConstant.borderStoke,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    SizeConstant.s2,
                                  ),
                                ),
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                              ),
                              onSubmitted: (value) {
                                curBtn = "All";
                                context.read<ProductBloc>().getProductList(
                                  keywords: _searchController.text,
                                );
                              },
                            ),
                          ),
                        ),
                        10.boxHeight,
                        _buildSubCategoryList(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: BlocBuilder<ProductBloc, ApiState>(
              builder: (context, state) {
                if (state is ApiSuccess<List<ProductData>>) {
                  if (state.data.isEmpty) {
                    return CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(child: 10.boxHeight),
                        SliverToBoxAdapter(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.15,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Center(
                            child: Image.asset(
                              height: 200.fSize,
                              width: 200.fSize,
                              ImageConstant.noproduct,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return getList(state.data);
                }

                if (state is ApiSuccessNoMoreData<List<ProductData>>) {
                  return getList(state.data);
                }

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

                if (state is ApiFailure) {
                  return ApiErrorWidget(
                    onRetry: () {
                      context.read<ProductBloc>().getProductList();
                    },
                  );
                }

                return SizedBox.shrink();
              },
            ),
          );
        },
      ),
    );
  }

  Widget getList(List<ProductData> list) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      controller: _refreshController,
      onLoading: () {
        _loadProducts(append: true);
      },
      onRefresh: () {
        _searchController.clear();
        curBtn = "All";
        _loadProducts(refresh: true);
      },
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: 10.boxHeight),
          SliverList.separated(
            itemCount: list.length,
            itemBuilder: (context, index) => FruitItemCard(data: list[index]),
            separatorBuilder: (context, index) => 10.boxHeight,
          ),
        ],
      ),
    );
  }

  void _loadProducts({bool append = false, bool refresh = false}) {
    context.read<ProductBloc>().getProductList(
      shouldAppend: append,
      category: "All" == curBtn ? null : categoryId,
      refresh: refresh,
    );
  }

  Widget _buildSubCategoryList() {
    return Container(
      height: 50.fSize,
      width: double.infinity,
      margin: EdgeInsets.only(left: 8, right: 8),
      child: BlocBuilder<SubCategoryBloc, ApiState>(
        builder: (context, state) {
          if (state is ApiSuccess<List<SubCategoryData>>) {
            var list = state.data;
            if (list.isEmpty && data.isNotEmpty) {
              return Row(
                children: [
                  Container(
                    margin: 8.leftSpacing,
                    width: 80.fSize,
                    height: 44.fSize,
                    child: FruitButtonWidget(
                      title: "All",
                      bgColor: ColorConstant.primaryMainColor,
                      textColor: ColorConstant.whiteColor,
                      onTap: () {
                        _searchController.clear();
                        context.read<ProductBloc>().getProductList(
                          refresh: true,
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: [0, 0].symmetricPadding,
              itemCount: list.length + 1,
              separatorBuilder: (index, dimensions) => 0.boxWidth,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Container(
                    margin: EdgeInsets.only(left: 8, right: 8, bottom: 4),
                    width: 80.fSize,
                    height: 60.fSize,

                    child: FruitButtonWidget(
                      title: "All",
                      bgColor: "All" == curBtn
                          ? ColorConstant.primaryMainColor
                          : Colors.white,
                      textColor: "All" == curBtn
                          ? ColorConstant.whiteColor
                          : ColorConstant.primaryMainColor,
                      onTap: () {
                        setState(() {
                          curBtn = "All";
                          _searchController.clear();
                          context.read<ProductBloc>().getProductList(
                            refresh: true,
                          );
                        });
                      },
                    ),
                  );
                }
                return Container(
                  height: 60.fSize,
                  margin: EdgeInsets.only(bottom: 4, right: 10),

                  child: FruitButtonWidget(
                    title: list[index - 1].enName ?? "",
                    bgColor: list[index - 1].enName == curBtn
                        ? ColorConstant.primaryMainColor
                        : Colors.white,
                    textColor: list[index - 1].enName == curBtn
                        ? ColorConstant.whiteColor
                        : ColorConstant.primaryMainColor,
                    onTap: () {
                      setState(() {
                        curBtn = list[index - 1].enName ?? "";
                        _searchController.clear();
                        context.read<ProductBloc>().getProductList(
                          category: (list[index - 1].id ?? 0).toInt(),
                          refresh: true,
                        );
                      });
                    },
                  ),
                );
              },
            );
          }

          return FruitButtonWidget(
            title: "All",
            bgColor: ColorConstant.primaryMainColor,
            textColor: ColorConstant.whiteColor,
            onTap: () {
              _searchController.clear();
              context.read<ProductBloc>().getProductList(refresh: true);
            },
          );
        },
      ),
    );
  }

}

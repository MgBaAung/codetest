import 'package:b2b_freshmore/base_architecture/domain/model/book_mark_model.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_state.dart';
import 'package:b2b_freshmore/base_architecture/state_management/cubit/holder_cubilt.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/book_mark_bloc.dart';
import 'package:b2b_freshmore/injection_container.dart';
import 'package:b2b_freshmore/presentation/global/app_theme.dart';
import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/custom_error_widget.dart';
import 'package:b2b_freshmore/presentation/global/extension/dialog_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/global/image_constant.dart';
import 'package:b2b_freshmore/presentation/global/navigation_service.dart';
import 'package:b2b_freshmore/presentation/screen/bookmark/component/book_mark_appbar.dart';
import 'package:b2b_freshmore/presentation/screen/bookmark/component/book_mark_item.dart';
import 'package:b2b_freshmore/presentation/screen/bookmark/component/book_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key, required this.refreshController});
  final RefreshController refreshController;

  @override
  State<BookmarkScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<BookmarkScreen> {
  int? currentUserId = getIt<HolderCubit>().state;

  @override
  void initState() {
    context.read<BookMarkBloc>().getBookMarks();
    super.initState();
  }

  int page = 1;
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<BookMarkBloc, ApiState>(
          listener: (context, state) {
            if (state is ApiFailure) {
              context.showNoticeBox(
                titleText: "Category List",
                contentText: state.message,
              );
            }
            if (state is ApiSuccess) {
              widget.refreshController.loadComplete();
            }
            if (state is ApiSuccessNoMoreData<List<ProductData>>) {
              widget.refreshController.loadNoData();
            }
          },
        ),
        BlocListener<CreateBookMarkBloc, ApiState>(
          listener: (context, state) {
            if (state is ApiLoading) {
              context.showLoading();
            }

            if (state is ApiSuccess) {
              context.hideLoading();
              context.read<BookMarkBloc>().getBookMarks();
              context.showNoticeBox(
                titleColor: ColorConstant.secondaryColor,
                titleText: "Remove Bookmark",
                contentText: "Remove Bookmark Successfully!",
              );
            }

            if (state is ApiFailure) {
              context.hideLoading();
              context.showNoticeBox(
                titleText: "Bookmark",
                contentText: state.message,
              );
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          leading: IconButton(
            onPressed: () {
              NavigationService.instance.goBack();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 18,
              color: ColorConstant.whiteColor,
            ),
          ),
          titleSpacing: 0,
          title: BookMarkAppbar(),
        ),
        body: BlocBuilder<BookMarkBloc, ApiState>(
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
            if (state is ApiSuccess<List<ProductData>>) {
              final bookList = state.data;
              if (bookList.isEmpty) {
                return SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  header: WaterDropHeader(),
                  controller: widget.refreshController,
                  onRefresh: () {
                    page = 1;
                    _loadProducts();
                  },
                  child: Center(
                    child: Image.asset(
                      height: 200.fSize,
                      width: 200.fSize,
                      ImageConstant.bookMark,
                    ),
                  ),
                );
              }
              return getList(bookList);
            }
            if (state is ApiSuccessNoMoreData<List<ProductData>>) {
              return getList(state.data);
            }
            if (state is ApiFailure) {
              return ApiErrorWidget(
                onRetry: () {
                  page = 1;
                  context.read<BookMarkBloc>().getBookMarks();
                },
              );
            }
            return SmartRefresher(
              controller: widget.refreshController,
              onRefresh: () async {
                page = 1;

                context.read<BookMarkBloc>().getBookMarks();
              },
              child: SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }

  Widget getList(List<ProductData> bookList) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      controller: widget.refreshController,
      onLoading: () {
        page++;
        _loadProducts(append: true);
      },
      onRefresh: () {
        page = 1;
        _loadProducts();
      },
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 15)),
          SliverList.separated(
            itemCount: bookList.length,
            itemBuilder: (context, index) {
              return BookMarkItem(
                onPress: () {
                  context.read<CreateBookMarkBloc>().delete(
                    productId: (bookList[index].id ?? 0).toInt(),
                    userId: currentUserId!,
                  );
                },
                data: bookList[index],
              );
            },
            separatorBuilder: (context, index) => 10.boxHeight,
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }

  void _loadProducts({bool append = false}) {
    context.read<BookMarkBloc>().getBookMarks(shouldAppend: append, page: page);
  }
}

import 'package:b2b_freshmore/base_architecture/domain/model/book_mark_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/cart_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/product_model.dart'
    as p;
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_state.dart';
import 'package:b2b_freshmore/base_architecture/state_management/cubit/holder_cubilt.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/book_mark_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/cart_bloc.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/product_detail_bloc.dart';
import 'package:b2b_freshmore/injection_container.dart';
import 'package:b2b_freshmore/presentation/global/app_bar_widget.dart';
import 'package:b2b_freshmore/presentation/global/app_route_constant.dart';
import 'package:b2b_freshmore/presentation/global/app_theme.dart';
import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/custom_button.dart';
import 'package:b2b_freshmore/presentation/global/custom_error_widget.dart';
import 'package:b2b_freshmore/presentation/global/enumeration.dart';
import 'package:b2b_freshmore/presentation/global/extension/dialog_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/string_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/text_extension.dart';
import 'package:b2b_freshmore/presentation/global/navigation_service.dart';
import 'package:b2b_freshmore/presentation/global/size_constant.dart';
import 'package:b2b_freshmore/presentation/screen/fruits/component/animated_image_slider.dart';
import 'package:b2b_freshmore/presentation/screen/fruits/component/fruit_detail_item.dart';
import 'package:b2b_freshmore/presentation/screen/fruits/component/product_cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FruitsDetailScreen extends StatefulWidget {
  final int id;
  const FruitsDetailScreen({super.key, required this.id});

  @override
  State<FruitsDetailScreen> createState() => _FruitsDetailScreenState();
}

class _FruitsDetailScreenState extends State<FruitsDetailScreen> {
  int? currentUserId = getIt<HolderCubit>().state;

  @override
  void initState() {
    context.read<ProductDetailBloc>().getProductDetail(id: widget.id);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CreateBookMarkBloc, ApiState>(
          listener: (context, state) {
            if (state is ApiLoading) {
              context.showLoading();
            }

            if (state is ApiSuccess<BookMarkModel>) {
              context.hideLoading();
              context.read<ProductDetailBloc>().getProductDetail();
              context.showNoticeBox(
                titleText: "Bookmark",
                contentText: "Bookmark Successfully!",
                titleColor: ColorConstant.primaryMainColor,
              );
            }

            if (state is ApiOperationSuccess) {
              context.hideLoading();
              context.read<ProductDetailBloc>().getProductDetail();
              context.showNoticeBox(
                titleText: "Remove Bookmark",
                contentText: "Remove bookmark Successfully!",
                titleColor: ColorConstant.secondaryColor,
              );
            }

            if (state is ApiFailure) {
              context.hideLoading();
              context.showNoticeBox(
                titleText: "Book Mark",
                contentText: state.message,
              );
            }
          },
        ),
        BlocListener<ProductDetailBloc, ApiState>(
          listener: (context, state) {
            if (state is ApiLoading) {
              context.showLoading();
            }

            if (state is ApiSuccess<p.ProductModel>) {
              context.hideLoading();
            }

            if (state is ApiFailure) {
              context.hideLoading();
              context.showNoticeBox(
                titleText: "Product Detail",
                contentText: state.message,
              );
            }
          },
        ),
        BlocListener<CartBloc, ApiState>(
          listener: (context, state) {
            if (state is ApiLoading) {
              context.showLoading();
            }

            if (state is ApiSuccess<CartModel>) {
              context.read<CartListBloc>().getCartList();
              context.hideLoading();
              context.showNoticeBox(
                titleText: "Add to cart.",
                contentText:
                    "This product is waiting for checkout in your cart.",
                actions: [
                  Container(
                    height: 46.v,
                    padding: 5.rightSpacing,
                    child: CustomElevatedButton(
                      fSize: 16,
                      bgColor: ColorConstant.whiteColor,
                      borderColor: Color(0xFFE8E8E8),
                      btnTextColor: ColorConstant.blcakColor,
                      btnLabel: "Still page",
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
                      bgColor: ColorConstant.primaryMainColor,
                      btnLabel: "Go to cart",
                      onPressedFun: () {
                        NavigationService.instance.pushReplacementNamed(
                          AppRoute.cartPage,
                        );
                      },
                    ),
                  ),
                ],
              );
            }

            if (state is ApiFailure) {
              context.hideLoading();
              context.showNoticeBox(
                titleText: "Add to cart.",
                contentText: state.message,
              );
            }
          },
        ),
      ],
      child: BlocBuilder<ProductDetailBloc, ApiState>(
        builder: (context, state) {
          p.ProductModel? productModel;
          if (state is ApiSuccess<p.ProductModel>) {
            productModel = state.data;
          }

          if (state is ApiFailure) {
            return ApiErrorWidget(
              onRetry: () {
                context.read<ProductDetailBloc>().getProductDetail();
              },
            );
          }
          return Scaffold(
            appBar: customAppbar(
              title: productModel?.productData?[0].name ?? "",
              context: context,
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: list(product: productModel?.productData?[0]),
              ),
            ),
            bottomNavigationBar: ProductCartWidget(product: productModel),
          );
        },
      ),
    );
  }

  List<Widget> list({p.ProductData? product}) {
    return [
      BlocSelector<CreateBookMarkBloc, ApiState, bool>(
        selector: (state) {
          if (state is ApiSuccess<p.ProductModel>) {
            return state.data.productData?[0].isBookmark ?? false;
          }
          return false;
        },
        builder: (context, state) {
          return AnimatedImageSlider(
            isBookMar: product?.isBookmark ?? false,
            images: product?.images ?? [],
            onPress: () {
              bool isBookMark = product?.isBookmark ?? false;
              if (isBookMark) {
                context.read<CreateBookMarkBloc>().delete(
                  productId: (product?.id ?? 0).toInt(),
                  userId: currentUserId!,
                );
              } else {
                context.read<CreateBookMarkBloc>().book(
                  (product?.id ?? 0).toInt(),
                );
              }
            },
          );
        },
      ),

      Container(
        color: ColorConstant.whiteColor,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.boxHeight,
            (product?.featStatus != null &&
                    product?.featStatus == FeatStatus.Recommended.name)
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      padding: [5, 10].symmetricPadding,
                      decoration: BoxDecoration(
                        color: ColorConstant.blueColor,
                        borderRadius: BorderRadius.circular(SizeConstant.s1),
                      ),
                      child: Text(
                        product?.featStatus ?? "",
                        style: context.regular(
                          fSize: 16,
                          color: ColorConstant.whiteColor,
                        ),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            10.boxHeight,
            FruitDetailItem(title: "Product Name", value: product?.name ?? ""),
            10.boxHeight,
            FruitDetailItem(
              title: "Category",
              value: product?.categoryName ?? "",
            ),
            10.boxHeight,
            FruitDetailItem(title: "SKU", value: product?.sku ?? ""),
            10.boxHeight,
            FruitDetailItem(
              title: "UOM",
              value: "${product?.uomQty ?? "1"} ${product?.unit?.name ?? ""}",
            ),
            10.boxHeight,
            FruitDetailItem(
              title: "Price",
              value:
                  "${(product?.price ?? 0).toMoneyFormat()} ${product?.currency ?? "MMK"}",
            ),
            10.boxHeight,
            FruitDetailItem(
              title: "Latest Update",
              value: (product?.updatedAt ?? "").toTimeAgo(),
            ),
            10.boxHeight,
          ],
        ),
      ),
    ];
  }
}

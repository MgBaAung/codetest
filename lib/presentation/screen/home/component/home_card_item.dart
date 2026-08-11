import 'package:b2b_freshmore/base_architecture/domain/model/category_model.dart';
import 'package:b2b_freshmore/presentation/global/app_theme.dart';
import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/text_extension.dart';
import 'package:b2b_freshmore/presentation/global/image_constant.dart';
import 'package:b2b_freshmore/presentation/global/size_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeCardItem extends StatelessWidget {
  final CategoryData categoryData;
  final VoidCallback onTap;
  const HomeCardItem({
    super.key,
    required this.categoryData,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: [8, 16].symmetricPadding,
        decoration: BoxDecoration(
          color: ColorConstant.primaryMainColor,
          borderRadius: BorderRadius.circular(SizeConstant.s6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: categoryData.imageUrl ?? "",
              height: 40.fSize,
              width: 40.fSize,
              fit: BoxFit.cover,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.white.withOpacity(0.3),
                highlightColor: Colors.white.withOpacity(0.1),
                child: Container(
                  height: 60.fSize,
                  width: 60.fSize,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Image.asset(
                ImageConstant.fruids,
                height: 60.fSize,
                width: 60.fSize,
              ),
            ),
            4.boxHeight,
            Text(
              categoryData.enName ?? "",
              style: context.medium(color: ColorConstant.whiteColor),
            ),
          ],
        ),
      ),
    );
  }
}

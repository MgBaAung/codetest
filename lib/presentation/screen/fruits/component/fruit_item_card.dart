import 'package:b2b_freshmore/base_architecture/domain/model/product_model.dart';
import 'package:b2b_freshmore/presentation/global/app_route_constant.dart';
import 'package:b2b_freshmore/presentation/global/app_theme.dart';
import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/enumeration.dart';
import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/text_extension.dart';
import 'package:b2b_freshmore/presentation/global/navigation_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';

class FruitItemCard extends StatelessWidget {
  final ProductData data;
  const FruitItemCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigationService.instance.pushNamed(
          AppRoute.fruitDetail,
          args: (data.id ?? 0).toInt(),
        );
      },
      child: Container(
        margin: [0, 16].symmetricPadding,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Stack(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                  child: Container(
                    width: 100.fSize,
                    height: 100.fSize,
                    color: const Color(0xFFF9D5B8),
                    child: data.images!.isEmpty
                        ? Icon(Icons.image_not_supported, color: Colors.grey)
                        : CachedNetworkImage(
                            cacheManager: GetIt.I<CacheManager>(),
                            imageUrl: data.images![0].url ?? "",
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                            cacheKey:
                                data.images![0].url?.split("?").first ?? "",
                            errorWidget: (context, url, error) => Icon(
                              Icons.image_not_supported,
                              color: Colors.grey,
                            ),
                            useOldImageOnUrlChange: true,
                          ),
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 12,
                      right: 12,
                      bottom: 12,
                      top: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          data.name ?? "",
                          style: context.regular(fSize: 16),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        8.boxHeight,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${data.uomQty ?? "1"} ${data.unit?.name ?? ""}",
                              style: context.regular(fSize: 16),
                            ),
                            Row(
                              children: [
                                Text(
                                  (data.price ?? 0).toMoneyFormat(),
                                  style: context.semibold(fSize: 16),
                                ),
                                Icon(
                                  PricingStatus.fromString(
                                    data.priceStatus ?? "",
                                  ).icon,
                                  color: PricingStatus.fromString(
                                    data.priceStatus ?? "",
                                  ).color,
                                  size: 20,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            (data.featStatus != null &&
                    data.featStatus == FeatStatus.Recommended.name)
                ? Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: ColorConstant.blueColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      child: Text(
                        data.featStatus ?? "",
                        style: context.regular(
                          fSize: 12,
                          color: ColorConstant.whiteColor,
                        ),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

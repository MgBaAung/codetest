import 'package:b2b_freshmore/base_architecture/domain/model/cart_model.dart';
import 'package:b2b_freshmore/presentation/global/app_theme.dart';
import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/text_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';

class OrderSummaryItem extends StatelessWidget {
  final DataModel? data;
  const OrderSummaryItem({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            child: Container(
              width: 72.fSize,
              height: 72.fSize,
              color: const Color(0xFFF9D5B8),
              child:
                  (data?.product?.images == null ||
                      data?.product?.images!.first.url == null ||
                      data!.product!.images!.first.url!.isEmpty)
                  ? Icon(Icons.image_not_supported, color: Colors.grey)
                  : CachedNetworkImage(
                      cacheManager: GetIt.I<CacheManager>(),
                      imageUrl: data!.product!.images!.first.url ?? "",
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      cacheKey: data!.product!.images!.first.url!
                          .split("?")
                          .first,
                      errorWidget: (context, url, error) =>
                          Icon(Icons.image_not_supported, color: Colors.grey),
                      useOldImageOnUrlChange: true,
                    ),
            ),
          ),

          12.boxWidth,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  data?.product?.nameEn ?? "",
                  style: context.bold(fSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
                8.boxHeight,
                Text(
                  "${data?.product?.uomQty ?? 0} ${data?.product?.unit?.name ?? ""}",
                  style: context.regular(fSize: 12),
                ),
                8.boxHeight,
                Text(
                  "${(data?.price ?? 0).toMoneyFormat()} ${(data?.currency ?? "").toLowerCase()} each",
                  style: context.regular(fSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

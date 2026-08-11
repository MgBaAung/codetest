import 'package:b2b_freshmore/presentation/global/app_theme.dart';
import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/text_extension.dart';
import 'package:b2b_freshmore/presentation/global/size_constant.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class NotificationTitleWidget extends StatelessWidget {
  const NotificationTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //NavigationService.instance.pushNamed(AppRoute.notiDetail);
      },
      child: Container(
        margin: EdgeInsets.only(
          left: SizeConstant.s1,
          right: SizeConstant.s1,
          top: SizeConstant.f1,
        ),
        padding: [14, 14].symmetricPadding,
        decoration: BoxDecoration(
          color: ColorConstant.whiteColor,
          borderRadius: BorderRadius.circular(SizeConstant.s2),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: ColorConstant.backgroundColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                size: 24.fSize,
                LucideIcons.bell,
                color: ColorConstant.primaryMainColor,
              ),
            ),
            SizeConstant.s2.boxWidth,
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Notification Title", style: context.medium()),
                      Row(
                        children: [
                          Text(
                            "45 min ago",
                            style: context.medium(
                              fSize: SizeConstant.f3,
                              color: ColorConstant.greyColor,
                            ),
                          ),
                          Container(
                            margin: SizeConstant.s3.leftSpacing,
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  4.boxHeight,
                  Text(
                    "Lorem ipsum dolor sit amet consectetur. Nullam ut vitae condimentum tortor. Lorem ipsum dolor sit amet consectetur. ",
                    style: context.regular(
                      color: ColorConstant.greyColor,
                      fSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

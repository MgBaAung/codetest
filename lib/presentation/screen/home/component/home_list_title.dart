import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/text_extension.dart';
import 'package:b2b_freshmore/presentation/global/size_constant.dart';
import 'package:flutter/material.dart';


class HomeListTitle extends StatelessWidget {
  final IconData iconData;
  final String title;
  final VoidCallback onTap;
  const HomeListTitle({
    super.key,
    required this.iconData,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: SizeConstant.s5.topSpacing,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(iconData, color: ColorConstant.primaryMainColor),
                8.boxWidth,
                Text(title, style: context.regular(fSize: 16)),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: ColorConstant.primaryMainColor,
              size: SizeConstant.s4,
            ),
          ],
        ),
      ),
    );
  }
}

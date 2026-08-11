import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/text_extension.dart';
import 'package:flutter/material.dart';

class ProfileItem extends StatelessWidget {
  final String title;
  final String value;
  const ProfileItem({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 12.topSpacing,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: context.medium(fSize: 16)),
          2.boxHeight,
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.regular(fSize: 16, color: ColorConstant.greyColor),
          ),
        ],
      ),
    );
  }
}

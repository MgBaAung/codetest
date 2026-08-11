import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/text_extension.dart';
import 'package:flutter/material.dart';

class FruitDetailItem extends StatelessWidget {
  final String title;
  final String value;
  const FruitDetailItem({super.key, required this.title, required this.value});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: [0, 20].symmetricPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: context.medium(color: ColorConstant.greyColor)),
          Text(
            value,
            style: context.medium(fSize: 16),
            overflow: TextOverflow.visible,
            softWrap: false,
          ),
        ],
      ),
    );
  }
}

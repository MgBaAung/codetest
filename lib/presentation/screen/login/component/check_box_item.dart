import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/text_extension.dart';
import 'package:b2b_freshmore/presentation/global/size_constant.dart';
import 'package:flutter/material.dart';


class CheckBoxItem extends StatelessWidget {
  final bool value;
  final void Function(bool?)? onChanged;
  const CheckBoxItem({super.key, required this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          activeColor: ColorConstant.primaryMainColor,
          value: value,
          onChanged: onChanged,
        ),
        SizeConstant.s6.boxWidth,
        Text(
          "Remember me",
          style: context.regular(
            fSize: SizeConstant.f1,
            color: ColorConstant.greyColor,
          ),
        ),
      ],
    );
  }
}

import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/text_extension.dart';
import 'package:b2b_freshmore/presentation/global/size_constant.dart';
import 'package:flutter/material.dart';

class FruitButtonWidget extends StatelessWidget {
  final String title;
  final Color bgColor;
  final Color textColor;
  final VoidCallback onTap;
  const FruitButtonWidget({
    super.key,
    required this.title,
    required this.bgColor,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: [3, 10].symmetricPadding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeConstant.s2),
          color: bgColor,
        ),

        child: Center(
          child: Text(
            title,
            style: context.medium(fSize: 12, color: textColor),
          ),
        ),
      ),
    );
  }
}

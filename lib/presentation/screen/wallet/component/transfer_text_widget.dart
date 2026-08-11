import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/text_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class TransferTextWidget extends StatelessWidget {
  final String name;
  final String value;
  final bool isNumber;
  const TransferTextWidget({
    super.key,
    required this.name,
    required this.value,
    this.isNumber = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 0.allSpacing,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Text(
              "$name :  $value",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.regular(fSize: 16),
            ),
          ),

          isNumber
              ? Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    splashColor: Colors.grey.withValues(alpha: 0.3),
                    highlightColor: Colors.grey.withValues(alpha: (0.1)),
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: value)).then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("$value copied to clipboard"),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      });
                    },
                    child: Padding(
                      padding: 8.allSpacing,
                      child: Icon(
                        LucideIcons.copy,
                        size: 18,
                        color: ColorConstant.primaryMainColor,
                      ),
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}

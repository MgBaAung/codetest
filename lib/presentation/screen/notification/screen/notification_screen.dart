import 'package:b2b_freshmore/presentation/global/app_theme.dart';
import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/extension/text_extension.dart';
import 'package:b2b_freshmore/presentation/global/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            color: ColorConstant.primaryMainColor,
            child: TabBar(
              indicatorColor: ColorConstant.whiteColor,
              tabs: [
                Tab(
                  child: Text(
                    "All",
                    style: context.semibold(color: ColorConstant.whiteColor),
                  ),
                ),
                Tab(
                  child: Text(
                    "Unread",
                    style: context.semibold(color: ColorConstant.whiteColor),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 240,
                    width: 220,
                    child: SvgPicture.asset(
                      fit: BoxFit.contain,
                      ImageConstant.notiemptyIcon,
                      width: 225.fSize,
                      height: 247.fSize,
                    ),
                  ),
                ),

                // ListView(
                //   children: [
                //     NotificationTitleWidget(),
                //     NotificationTitleWidget(),
                //     NotificationTitleWidget(),
                //     NotificationTitleWidget(),
                //   ],
                // ),
                Container(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 240,
                    width: 220,
                    child: SvgPicture.asset(
                      fit: BoxFit.contain,
                      ImageConstant.notiemptyIcon,
                      width: 225.fSize,
                      height: 247.fSize,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

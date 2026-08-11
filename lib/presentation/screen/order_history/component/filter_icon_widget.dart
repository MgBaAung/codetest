import 'package:b2b_freshmore/base_architecture/state_management/implements/order_history_bloc.dart';
import 'package:b2b_freshmore/presentation/global/app_theme.dart';
import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/custom_button.dart';
import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/string_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/text_extension.dart';
import 'package:b2b_freshmore/presentation/global/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class FilterIconWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  const FilterIconWidget({super.key, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        textEditingController.clear();
        _showCustomDateBottomSheet(context);
      },
      child: Container(
        height: 50.v,
        width: 50.v,
        margin: 10.leftSpacing,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: ColorConstant.primaryMainColor,
        ),
        child: Icon(LucideIcons.calendar, color: ColorConstant.whiteColor),
      ),
    );
  }

  void _showCustomDateBottomSheet(BuildContext context) {
    int selectedYear = DateTime.now().year;
    Month? selectedMonth;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
      ),
      builder: (context) {
        bool isDesktop = MediaQuery.of(context).size.width > 600;
        return SafeArea(
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: [0, 16].symmetricPadding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Filter", style: context.semibold(fSize: 24)),
                        IconButton(
                          onPressed: () {
                            NavigationService.instance.goBack();
                          },
                          icon: Icon(Icons.close),
                        ),
                      ],
                    ),
                  ),
                  10.boxHeight,
                  Container(
                    margin: [0, 16].symmetricPadding,
                    padding: 10.topSpacing,
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorConstant.borderStoke),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: 16.leftSpacing,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: ColorConstant.borderStoke,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.chevron_left),
                                onPressed: () {
                                  setModalState(() {
                                    selectedYear--;
                                  });
                                },
                              ),
                            ),
                            Text(
                              "$selectedYear",
                              style: context.medium(fSize: 18),
                            ),
                            Container(
                              margin: 16.rightSpacing,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: ColorConstant.borderStoke,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.chevron_right),
                                onPressed: () {
                                  setModalState(() {
                                    selectedYear++;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        10.boxHeight,
                        GridView.builder(
                          shrinkWrap: true,
                          padding: 0.allSpacing,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                mainAxisExtent: isDesktop ? 140 : 100,
                              ),
                          itemCount: Month.values.length,

                          itemBuilder: (context, index) {
                            final month = Month.values[index];
                            final isSelected = selectedMonth == month;

                            return InkWell(
                              onTap: () {
                                setModalState(() => selectedMonth = month);
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? ColorConstant.primaryMainColor
                                      : ColorConstant.whiteColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  month.name.capitalize(),
                                  style: context.regular(
                                    fSize: 16,
                                    color: isSelected
                                        ? ColorConstant.whiteColor
                                        : ColorConstant.blcakColor,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  16.boxHeight,
                  Padding(
                    padding: [0, 16].symmetricPadding,
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomElevatedButton(
                            btnLabel: "Clear Filter",
                            bgColor: ColorConstant.whiteColor,
                            btnTextColor: ColorConstant.textColor,
                            borderColor: ColorConstant.borderStoke,
                            elevation: 0,
                            fSize: 16,
                            onPressedFun: () {
                              if (selectedMonth != null) {
                                setModalState(() {
                                  selectedMonth = null;
                                  context.read<OrderHistoryBloc>().getList();
                                });
                              }

                              Navigator.pop(context);
                            },
                          ),
                        ),
                        8.width,
                        Expanded(
                          child: CustomElevatedButton(
                            btnLabel: "Apply",
                            fSize: 16,
                            elevation: 0,
                            onPressedFun: () {
                              if (selectedMonth != null) {
                                String formattedDate =
                                    "${selectedMonth!.value}-$selectedYear";
                                context.read<OrderHistoryBloc>().getList(
                                  month: formattedDate,
                                );
                              }
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  5.boxHeight,
                ],
              );
            },
          ),
        );
      },
    );
  }
}

enum Month {
  jan,
  feb,
  mar,
  apr,
  may,
  jun,
  jul,
  aug,
  sep,
  oct,
  nov,
  dec;

  String get value {
    int index = this.index + 1;
    return index.toString().padLeft(2, '0');
  }
}

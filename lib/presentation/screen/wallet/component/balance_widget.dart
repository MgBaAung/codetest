import 'package:b2b_freshmore/base_architecture/domain/model/wallet_model.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_state.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/wallet_bloc.dart';
import 'package:b2b_freshmore/presentation/global/app_theme.dart';
import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/text_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class BalanceWidget extends StatefulWidget {
  const BalanceWidget({super.key});

  @override
  State<BalanceWidget> createState() => _BalanceWidgetState();
}

class _BalanceWidgetState extends State<BalanceWidget> {
  final ValueNotifier<bool> _showBalance = ValueNotifier(false);
  WelletDataModel? model;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, ApiState>(
      builder: (context, state) {
        if (state is ApiSuccess<WalletModel>) {
          model = state.data.data;
        }

        return Container(
          margin: [10, 16].symmetricPadding,
          height: 107.v,
          padding: [0, 16].symmetricPadding,
          decoration: BoxDecoration(
            color: ColorConstant.whiteColor,
            border: Border.all(color: ColorConstant.borderStoke),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Balance", style: context.semibold(fSize: 24)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ValueListenableBuilder(
                    valueListenable: _showBalance,
                    builder: (context, value, child) {
                      return Text(
                        value
                            ? "${double.parse(model?.balance ?? "0").toMoneyFormat()} ${model?.currency ?? "mmk"}"
                            : "****",
                        style: context.bold(fSize: 23),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      );
                    },
                  ),
                  IconButton(
                    onPressed: () {
                      _showBalance.value = !_showBalance.value;
                    },
                    icon: ValueListenableBuilder(
                      valueListenable: _showBalance,
                      builder: (context, value, child) {
                        return Icon(
                          !value ? LucideIcons.eyeOff : LucideIcons.eye,
                          color: ColorConstant.primaryMainColor,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

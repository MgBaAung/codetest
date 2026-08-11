import 'package:b2b_freshmore/base_architecture/domain/model/payment_model.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_state.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/payment_bloc.dart';
import 'package:b2b_freshmore/presentation/global/app_theme.dart';
import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/extension/context_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/text_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';

class PaymentItemWidget extends StatelessWidget {
  final void Function(PaymentModel value) onTap;
  final PaymentModel? selectedPayment;
  const PaymentItemWidget({
    super.key,
    required this.onTap,
    this.selectedPayment,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentBloc, ApiState>(
      builder: (context, state) {
        if (state is ApiLoading) {
          return Container(
            margin: 8.topSpacing,
            padding: [10, 16].symmetricPadding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Color(0xFFD4D4D7), width: 1),
            ),
            child: Row(
              children: [
                Container(width: 24, height: 24, color: Colors.grey[300]),
                8.boxWidth,
                Container(width: 100, height: 16, color: Colors.grey[300]),
              ],
            ),
          );
        }
        if (state is ApiFailure) {
          return Text(
            state.message,
            style: context.regular(fSize: 14, color: Colors.red),
          );
        }
        if (state is ApiSuccess<List<PaymentModel>>) {
          return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: state.data.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: context.isMobile ? 2 : 3,
              childAspectRatio: 2.5,
              crossAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  onTap.call(state.data[index]);
                },
                child: Container(
                  margin: 8.topSpacing,
                  padding: [0, 8].symmetricPadding,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: (selectedPayment?.id == state.data[index].id)
                          ? ColorConstant.primaryMainColor
                          : Color(0xFFD4D4D7),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(4),
                        ),
                        child: Container(
                          width: 30.fSize,
                          height: 30.fSize,
                          color: const Color(0xFFF9D5B8),
                          child: state.data[index].logoUrl!.isEmpty
                              ? Icon(
                                  Icons.image_not_supported,
                                  color: Colors.grey,
                                )
                              : CachedNetworkImage(
                                  cacheManager: GetIt.I<CacheManager>(),
                                  imageUrl: state.data[index].logoUrl ?? "",
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                  cacheKey:
                                      state.data[index].logoUrl
                                          ?.split("?")
                                          .first ??
                                      "",
                                  errorWidget: (context, url, error) => Icon(
                                    Icons.image_not_supported,
                                    color: Colors.grey,
                                  ),
                                  useOldImageOnUrlChange: true,
                                ),
                        ),
                      ),

                      8.boxWidth,
                      Expanded(
                        child: Text(
                          state.data[index].name ?? "",
                          style: context.regular(fSize: 16),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}

import 'package:b2b_freshmore/base_architecture/domain/model/book_mark_model.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_state.dart';
import 'package:b2b_freshmore/base_architecture/state_management/implements/book_mark_bloc.dart';
import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/extension/text_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookMarkAppbar extends StatelessWidget {
  const BookMarkAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookMarkBloc, ApiState>(
      builder: (context, state) {
        List bookList = [];
        if (state is ApiSuccess<List<ProductData>>) {
          bookList = state.data;
        }
        if (state is ApiSuccessNoMoreData<List<ProductData>>) {
          bookList = state.data;
        }
        return Text(
          "Bookmarks ( ${bookList.length} )",
          textAlign: TextAlign.left,
          style: context.semibold(color: ColorConstant.whiteColor, fSize: 20),
        );
      },
    );
  }
}

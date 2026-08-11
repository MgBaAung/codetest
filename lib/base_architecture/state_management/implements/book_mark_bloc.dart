import 'package:b2b_freshmore/base_architecture/core/api_end_point.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/book_mark_model.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_event.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/base_bloc.dart';

class BookMarkBloc extends BaseBloc<ProductData> {
  BookMarkBloc({required super.crudUsecase});

  void getBookMarks({int page = 0, bool shouldAppend = false}) {
    add(
      FetchAllDataEvent(
        endpoint: bookMarkUrl,
        queryParams: {"page": page.toString(), "limit": 50.toString()},
        shouldAppend: shouldAppend,
        parser: (json) {
          final List<dynamic> dataList = json['data'] as List<dynamic>;
          return dataList.map((e) => ProductData().fromMap(e)).toList();
        },
      ),
    );
  }
}

class CreateBookMarkBloc extends BaseBloc<BookMarkModel> {
  CreateBookMarkBloc({required super.crudUsecase});

  void book(int productId) {
    var data = BookMarkModel(productId: productId);
    add(
      CreateDataEvent(
        endpoint: bookMarkUrl,
        data: data,
        parser: (json) => data.fromMap(json),
      ),
    );
  }

  void delete({required int productId, required int userId}) {
    add(
      DeleteDataEvent(
        id: '$userId/$productId',
        endpoint: bookMarkUrl,
        parser: (json) => BookMarkModel().fromMap(json),
      ),
    );
  }
}

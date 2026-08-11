import 'package:b2b_freshmore/base_architecture/core/api_end_point.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/category_model.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_event.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/base_bloc.dart';

class CategoryBloc extends BaseBloc<CategoryData> {
  CategoryBloc({required super.crudUsecase});

  String? keyword;
  int page = 1;

  void clean() {
    keyword = null;
  }

  void getCategoryList({
    String? keywords,
    bool shouldAppend = false,
    bool refresh = false,
  }) {
    if (refresh) {
      keyword = null;
    }
    if (shouldAppend) {
      page++;
    } else {
      page = 1;
    }

    keyword = keywords ?? keyword;
    Map<String, dynamic> map = {};
    if (keyword != null) {
      map["search"] = keyword;
    }
    map["page"] = page;
    map["limit"] = 50;

    add(
      FetchAllDataEvent(
        endpoint: categoryUrl,
        queryParams: map,
        parser: (json) {
          final List<dynamic> dataList = json['data'] as List<dynamic>;
          return dataList.map((e) => CategoryData().fromMap(e)).toList();
        },

        shouldAppend: shouldAppend,
      ),
    );
  }
}

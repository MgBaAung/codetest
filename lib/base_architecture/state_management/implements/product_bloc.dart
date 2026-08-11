import 'package:b2b_freshmore/base_architecture/core/api_end_point.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/product_model.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_event.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/base_bloc.dart';

class ProductBloc extends BaseBloc<ProductData> {
  ProductBloc({required super.crudUsecase});

  int? _ids;
  String? keyword;
  int page = 1;

  void setId(int id) {
    _ids = id;
  }

  void clean() {
    keyword = null;
  }

  void getProductList({
    int? id,
    bool shouldAppend = false,
    int? category,
    bool refresh = false,
    String? keywords,
  }) {
    _ids = id ?? _ids!;
    if (refresh) {
      keyword = null;
    }
    if (shouldAppend) {
      page++;
    } else {
      page = 1;
    }
    keyword = keywords ?? keyword;
    Map<String, dynamic> queryData = {
      "page": "$page",
      "limit": "${50}",
      "categoryId": "$_ids",
    };
    if (keyword != null) {
      queryData["search"] = keyword;
    }
    if (category != null) {
      queryData["subCategoryId"] = category;
    }
    add(
      FetchAllDataEvent(
        endpoint: productUrl,
        parser: (json) {
          final List<dynamic> dataList = json['data'] as List<dynamic>;
          return dataList.map((e) => ProductData().fromMap(e)).toList();
        },
        shouldAppend: shouldAppend,
        queryParams: queryData,
      ),
    );
  }
}

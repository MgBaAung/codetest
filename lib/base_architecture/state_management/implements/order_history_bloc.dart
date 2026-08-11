import 'package:b2b_freshmore/base_architecture/core/api_end_point.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/order_history_model.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_event.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/base_bloc.dart';

class OrderHistoryBloc extends BaseBloc<OrderHistoryModel> {
  OrderHistoryBloc({required super.crudUsecase});

  String? keyword;
  int page = 1;

  void clean() {
    keyword = null;
  }

  void getList({
    String? keywords,
    bool shouldAppend = false,
    bool refresh = false,
    String? month,
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
    if (month != null) {
      keyword = null;
      map["createdAt"] = month;
    }
    if (keyword != null) {
      map["search"] = keyword;
    }

    map["page"] = page;
    map["limit"] = 20;

    add(
      FetchAllDataEvent(
        endpoint: orderUrl,
        queryParams: map,
        shouldAppend: shouldAppend,
        isList: true,
        parser: (json) {
          final List<dynamic> dataList = json['data'] as List<dynamic>;
          return dataList.map((e) => OrderHistoryModel().fromMap(e)).toList();
        },
      ),
    );
  }
}

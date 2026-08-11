import 'package:b2b_freshmore/base_architecture/core/api_end_point.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/sub_category.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_event.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/base_bloc.dart';

class SubCategoryBloc extends BaseBloc<SubCategoryData> {
  SubCategoryBloc({required super.crudUsecase});

  void getSubCategry(int id) {
    add(
      FetchAllDataEvent(
        endpoint: subCategoryUrl,
        queryParams: {"categoryId": id},
        parser: (json) {
          final List<dynamic> dataList = json['data'] as List<dynamic>;
          return dataList.map((e) => SubCategoryData().fromMap(e)).toList();
        },
      ),
    );
  }
}

import 'package:b2b_freshmore/base_architecture/core/api_end_point.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/level_model.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/api_event.dart';
import 'package:b2b_freshmore/base_architecture/state_management/bloc/base_bloc.dart';

class LevelBloc extends BaseBloc<LevelModel> {
  LevelBloc({required super.crudUsecase});

  void getLevel(String id) {
    add(
      FetchDataEvent(
        endpoint: '$levelUrl/$id/users',
        parser: (json) => LevelModel().fromMap(json),
      ),
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';

class HolderCubit extends Cubit<int> {
  HolderCubit() : super(0);

  void setIndex(int index) {
    emit(index);
  }

  void reset() => emit(0);
}


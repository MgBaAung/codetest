import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presentation/global/enumeration.dart';

class BottomNavCubit extends Cubit<AppNavTab> {
  BottomNavCubit() : super(AppNavTab.home);
  void navIndexChange(AppNavTab index) => emit(index);
}

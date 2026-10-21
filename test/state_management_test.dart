import 'package:b2b_freshmore/base_architecture/state_management/cubit/bottom_nav_cubit.dart';
import 'package:b2b_freshmore/presentation/global/enumeration.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BottomNavCubit', () {
    late BottomNavCubit cubit;

    setUp(() => cubit = BottomNavCubit());
    tearDown(() => cubit.close());

    test('starts on the home tab', () {
      expect(cubit.state, AppNavTab.home);
    });

    test('emits selected tabs in order', () async {
      final states = cubit.stream.take(2).toList();

      cubit.navIndexChange(AppNavTab.order);
      cubit.navIndexChange(AppNavTab.wallet);

      await expectLater(
        states,
        completion([AppNavTab.order, AppNavTab.wallet]),
      );
      expect(cubit.state, AppNavTab.wallet);
    });
  });
}

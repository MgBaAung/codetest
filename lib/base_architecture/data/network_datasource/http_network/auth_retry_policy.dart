
import 'package:b2b_freshmore/base_architecture/state_management/implements/auth_bloc.dart';
import 'package:b2b_freshmore/presentation/global/app_route_constant.dart';
import 'package:b2b_freshmore/presentation/global/navigation_service.dart';
import 'package:http_interceptor/http_interceptor.dart';

import '../../../../injection_container.dart';
import '../../../../presentation/global/key_util.dart';
import '../../local_datasource/token_manager.dart';

class AuthRetryPolicy extends RetryPolicy {
  AuthRetryPolicy();

  @override
  int get maxRetryAttempts => 2;

  @override
  Future<bool> shouldAttemptRetryOnResponse(BaseResponse response) async {

    if (response.statusCode == 401 || response.statusCode == 403) {
      _handleLogout();
    }
    return super.shouldAttemptRetryOnResponse(response);
  }

  void _handleLogout() {
    getIt<AuthBloc>().clear();
    var tokenManager = getIt<TokenManager>();
    tokenManager.deleteToken(kAccess);
    tokenManager.deleteToken(kRefresh);
    NavigationService.instance.pushNamedAndRemoveUntil(AppRoute.loginPage);
  }
}

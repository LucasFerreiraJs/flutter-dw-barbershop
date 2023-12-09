import 'package:asyncstate/asyncstate.dart';
import 'package:dw_barbershop/src/core/exception/service_exception.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/providers/application_provider.dart';
import 'package:dw_barbershop/src/features/auth/login/login_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_vm.g.dart';

@riverpod
class LoginVm extends _$LoginVm {
  @override
  LoginState build() => LoginState.initial();

  Future<void> login(String email, String password) async {
    final loaderHandler = AsyncLoaderHandler()..start();
    final loginService = ref.watch(userLoginServiceProvider);

    final result = await loginService.execute(email, password);

    switch (result) {
      case Success():
        // * verificar tipo de login;
        break;
      // case Failure(exception: final exception):
      case Failure(exception: ServiceException(message: final message)):
        state = state.copyWith(LoginStateStatus.error, () => message);
    }

    loaderHandler.close();
  }
}

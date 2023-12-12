import 'package:asyncstate/asyncstate.dart';
import 'package:dw_barbershop/src/core/exception/service_exception.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/providers/application_provider.dart';
import 'package:dw_barbershop/src/features/auth/login/login_state.dart';
import 'package:dw_barbershop/src/model/user_model.dart';
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
        // invalidar cache
        ref.invalidate(getMeProvider);
        ref.invalidate(getMyBarbershopProvider);

        // * verificar tipo de login;
        final userModel = await ref.read(getMeProvider.future);
        switch (userModel) {
          case UserModelADM():
            state = state.copyWith(LoginStateStatus.admLogin, () => null);
          case UserModelEmployee():
            state = state.copyWith(LoginStateStatus.employeeLogin, () => null);
        }

        break;
      // case Failure(exception: final exception):
      case Failure(exception: ServiceException(message: final message)):
        state = state.copyWith(LoginStateStatus.error, () => message);
    }

    loaderHandler.close();
  }
}

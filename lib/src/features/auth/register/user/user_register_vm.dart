import 'package:asyncstate/asyncstate.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/providers/application_provider.dart';
import 'package:dw_barbershop/src/features/auth/register/user/user_register_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_register_vm.g.dart';

enum EUserRegisterStateStatus {
  initial,
  success,
  error,
}

@riverpod
class UserRegisterVm extends _$UserRegisterVm {
  @override
  EUserRegisterStateStatus build() => EUserRegisterStateStatus.initial;

  Future<void> register({required String name, required String email, required String password}) async {
    final userRegisterAdmService = ref.watch(userRegisterAdmServiceProvider);

    final userData = (
      name: name,
      email: email,
      password: password,
    );
    // final loaderHandler = AsyncLoaderHandler()..start();

    final registerResult = await userRegisterAdmService.execute(userData);
    switch (registerResult) {
      case Success():
        // loaderHandler.close();
        ref.invalidate(getMeProvider);
        state = EUserRegisterStateStatus.success;
        break;
      case Failure():
        // loaderHandler.close();
        state = EUserRegisterStateStatus.error;
        break;
    }
  }
}

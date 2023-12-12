import 'package:asyncstate/asyncstate.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/providers/application_provider.dart';
import 'package:dw_barbershop/src/features/auth/register/user_register_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'userregister_vm.g.dart';

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

    final registerResult = await userRegisterAdmService.execute(userData).asyncLoader();
    switch (registerResult) {
      case Success():
        ref.invalidate(getMeProvider);
        state = EUserRegisterStateStatus.success;
      case Failure():
        state = EUserRegisterStateStatus.error;
    }
  }
}

import 'package:dw_barbershop/src/core/constant/local_storage_key.dart';
import 'package:dw_barbershop/src/core/providers/application_provider.dart';
import 'package:dw_barbershop/src/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'splash_vm.g.dart';

enum ESplashState {
  initial,
  login,
  loggedADM,
  loggedEmployee,
  error,
}

@riverpod
class SplashVm extends _$SplashVm {
  @override
  Future<ESplashState> build() async {
    final sp = await SharedPreferences.getInstance();
    if (sp.containsKey(LocalStorageKeys.accessToken)) {
      ref
        ..invalidate(getMeProvider)
        ..invalidate(getMyBarbershopProvider);

      try {
        final userModel = await ref.watch(getMeProvider.future);

        return switch (userModel) {
          UserModelADM() => ESplashState.loggedADM,
          UserModelEmployee() => ESplashState.loggedEmployee,
        };
      } catch (e) {
        return ESplashState.login;
      }
    }

    return ESplashState.login;
  }
}

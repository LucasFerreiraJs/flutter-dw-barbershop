import 'package:dw_barbershop/src/core/constant/local_storage_key.dart';
import 'package:dw_barbershop/src/core/exception/auth_exception.dart';
import 'package:dw_barbershop/src/core/exception/service_exception.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/fp/nil.dart';
import 'package:dw_barbershop/src/repositories/user/user_repository.dart';
import 'package:dw_barbershop/src/services/user_login/user_login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLoginServiceImpl implements IUserLoginService {
  final IUserRepository userRepository;
  UserLoginServiceImpl({required this.userRepository});

  @override
  Future<Either<ServiceException, Nil>> execute(String email, String password) async {
    final loginResult = await userRepository.login(email, password);

    switch (loginResult) {
      case Success(value: final accessToken):
        final sp = await SharedPreferences.getInstance();
        sp.setString(LocalStorageKeys.accessToken, accessToken);
        return Success(nil);

      case Failure(exception: final exception):
        return switch (exception) {
          AuthError() => Failure(ServiceException(message: 'Erro ao realizar login')),
          AuthUnauthorizedException() => Failure(ServiceException(message: 'Login ou senha inválidos')),
        };
    }
  }
}

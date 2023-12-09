import 'package:dw_barbershop/src/core/exception/auth_exception.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';

abstract interface class IUserRepository {
  Future<Either<AuthException, String>> login(String email, String password);
}

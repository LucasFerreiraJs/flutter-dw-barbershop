import 'package:dw_barbershop/src/core/exception/auth_exception.dart';
import 'package:dw_barbershop/src/core/exception/respository_exceptions.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/model/user_model.dart';

abstract interface class IUserRepository {
  Future<Either<AuthException, String>> login(String email, String password);
  Future<Either<RepositoryException, UserModel>> me();
}

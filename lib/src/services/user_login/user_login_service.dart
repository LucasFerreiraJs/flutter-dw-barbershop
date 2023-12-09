import 'package:dw_barbershop/src/core/exception/service_exception.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/fp/nil.dart';

abstract interface class IUserLoginService {
  Future<Either<ServiceException, Nil>> execute(String email, String password);
}

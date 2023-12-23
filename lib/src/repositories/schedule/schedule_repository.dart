import 'package:dw_barbershop/src/core/exception/respository_exceptions.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/fp/nil.dart';

abstract interface class IScheduleRepository {
  Future<Either<RepositoryException, Nil>> scheduleClient(
      ({
        int barbershopId,
        int userId,
        String clientName,
        DateTime date,
        int time,
      }) scheduleData);
}

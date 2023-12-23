import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dw_barbershop/src/core/exception/respository_exceptions.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/fp/nil.dart';
import 'package:dw_barbershop/src/core/restClient/rest_client.dart';
import 'package:dw_barbershop/src/repositories/schedule/schedule_repository.dart';

class ScheduleRepositoryImpl implements IScheduleRepository {
  final RestClient restClient;
  ScheduleRepositoryImpl({
    required this.restClient,
  });

  @override
  Future<Either<RepositoryException, Nil>> scheduleClient(({int barbershopId, String clientName, DateTime date, int time, int userId}) scheduleData) async {
    try {
      await restClient.auth.post('/schedules', data: {
        'barbershop_id': scheduleData.barbershopId,
        'user_id': scheduleData.userId,
        'client_name': scheduleData.clientName,
        'date': scheduleData.date.toString(),
        'time': scheduleData.time,
      });

      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao register agendamento', error: e, stackTrace: s);
      return Failure(RepositoryException(message: 'Erro ao register agendamento'));
    }
  }
}

import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/restClient/rest_client.dart';
import 'package:dw_barbershop/src/core/ui/barbershop_nav_global_key.dart';
import 'package:dw_barbershop/src/model/barbershop_model.dart';
import 'package:dw_barbershop/src/model/user_model.dart';
import 'package:dw_barbershop/src/repositories/barbershop/barbershop_repository.dart';
import 'package:dw_barbershop/src/repositories/barbershop/barbershop_repository_impl.dart';
import 'package:dw_barbershop/src/repositories/user/user_repository.dart';
import 'package:dw_barbershop/src/repositories/user/user_repository_impl.dart';
import 'package:dw_barbershop/src/services/user_login/user_login_service.dart';
import 'package:dw_barbershop/src/services/user_login/user_login_service_impl.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'application_provider.g.dart';

// * singleton
@Riverpod(keepAlive: true)
RestClient restClient(RestClientRef ref) => RestClient();

@Riverpod(keepAlive: true)
IUserRepository userRepository(UserRepositoryRef ref) => UserRepositoryImpl(restClient: ref.read(restClientProvider));

@Riverpod(keepAlive: true)
IUserLoginService userLoginService(UserLoginServiceRef ref) => UserLoginServiceImpl(userRepository: ref.read(userRepositoryProvider));

@Riverpod(keepAlive: true)
Future<UserModel> getMe(GetMeRef ref) async {
  final response = await ref.watch(userRepositoryProvider).me();
  return switch (response) {
    Success(value: final userModel) => userModel,
    Failure(:final exception) => throw exception,
  };
}

@Riverpod(keepAlive: true)
IBarbershopRepository barbershopRepository(BarbershopRepositoryRef ref) => BarbershopRepositoryImpl(restClient: ref.watch(restClientProvider));

@Riverpod(keepAlive: true)
Future<BarbershopModel> getMyBarbershop(GetMyBarbershopRef ref) async {
  final userModel = await ref.watch(getMeProvider.future);

  final barbershopRepository = ref.watch(barbershopRepositoryProvider);
  final response = await barbershopRepository.getMyBarbershop(userModel);

  return switch (response) {
    Success(value: final barbershop) => barbershop,
    Failure(:final exception) => throw exception,
  };
}

@riverpod
Future<void> logout(LogoutRef ref) async {
  final sp = await SharedPreferences.getInstance();
  sp.clear();

  ref
    ..invalidate(getMeProvider)
    ..invalidate(getMyBarbershopProvider);

  Navigator.of(BarbershopNavGlobalKey.instance.navKey.currentContext!).pushNamedAndRemoveUntil('/auth/login', (route) => false);
}

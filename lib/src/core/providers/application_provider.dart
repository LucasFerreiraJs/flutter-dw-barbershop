import 'package:dw_barbershop/src/core/restClient/rest_client.dart';
import 'package:dw_barbershop/src/repositories/user/user_repository.dart';
import 'package:dw_barbershop/src/repositories/user/user_repository_impl.dart';
import 'package:dw_barbershop/src/services/user_login/user_login_service.dart';
import 'package:dw_barbershop/src/services/user_login/user_login_service_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'application_provider.g.dart';

// * singleton
@Riverpod(keepAlive: true)
RestClient restClient(RestClientRef ref) => RestClient();

@Riverpod(keepAlive: true)
IUserRepository userRepository(UserRepositoryRef ref) => UserRepositoryImpl(restClient: ref.read(restClientProvider));

@Riverpod(keepAlive: true)
IUserLoginService userLoginService(UserLoginServiceRef ref) => UserLoginServiceImpl(userRepository: ref.read(userRepositoryProvider));

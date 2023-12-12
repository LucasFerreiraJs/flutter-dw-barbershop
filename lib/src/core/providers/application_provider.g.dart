// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$restClientHash() => r'0ee58f1fd102b2016ed621885f1e8d52ed00da66';

/// See also [restClient].
@ProviderFor(restClient)
final restClientProvider = Provider<RestClient>.internal(
  restClient,
  name: r'restClientProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$restClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RestClientRef = ProviderRef<RestClient>;
String _$userRepositoryHash() => r'491349a4df544962b5bde830102f5089b8114d88';

/// See also [userRepository].
@ProviderFor(userRepository)
final userRepositoryProvider = Provider<IUserRepository>.internal(
  userRepository,
  name: r'userRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserRepositoryRef = ProviderRef<IUserRepository>;
String _$userLoginServiceHash() => r'44533dbe23ede25bbbdc18eeb6d3bb798f499d82';

/// See also [userLoginService].
@ProviderFor(userLoginService)
final userLoginServiceProvider = Provider<IUserLoginService>.internal(
  userLoginService,
  name: r'userLoginServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userLoginServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserLoginServiceRef = ProviderRef<IUserLoginService>;
String _$getMeHash() => r'fbf407e095230102630c8eb19825eeb1563d0efa';

/// See also [getMe].
@ProviderFor(getMe)
final getMeProvider = FutureProvider<UserModel>.internal(
  getMe,
  name: r'getMeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getMeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetMeRef = FutureProviderRef<UserModel>;
String _$barbershopRepositoryHash() =>
    r'7ba5b2f9172953919a16026c464ce4889d3ea4d6';

/// See also [barbershopRepository].
@ProviderFor(barbershopRepository)
final barbershopRepositoryProvider = Provider<IBarbershopRepository>.internal(
  barbershopRepository,
  name: r'barbershopRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$barbershopRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef BarbershopRepositoryRef = ProviderRef<IBarbershopRepository>;
String _$getMyBarbershopHash() => r'93e49ac7002aaab90a9fea70cf8c0afbe4c6ace0';

/// See also [getMyBarbershop].
@ProviderFor(getMyBarbershop)
final getMyBarbershopProvider = FutureProvider<BarbershopModel>.internal(
  getMyBarbershop,
  name: r'getMyBarbershopProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getMyBarbershopHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetMyBarbershopRef = FutureProviderRef<BarbershopModel>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';

enum ELoginStateStatus {
  initial,
  error,
  admLogin,
  employeeLogin,
}

class LoginState {
  final ELoginStateStatus status;
  final String? errorMessage;

  // construtor nomeado
  LoginState.initial() : this(status: ELoginStateStatus.initial);

  LoginState({required ELoginStateStatus this.status, this.errorMessage});

  LoginState copyWith(
    ELoginStateStatus? status,
    ValueGetter<String?>? error,
  ) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: error != null ? error() : this.errorMessage,
    );
  }
}

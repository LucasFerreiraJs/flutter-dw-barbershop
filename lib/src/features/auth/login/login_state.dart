import 'package:flutter/material.dart';

enum LoginStateStatus {
  initial,
  error,
  admLogin,
  employeeLogin,
}

class LoginState {
  final LoginStateStatus status;
  final String? errorMessage;

  // construtor nomeado
  LoginState.initial() : this(status: LoginStateStatus.initial);

  LoginState({required LoginStateStatus this.status, this.errorMessage});

  LoginState copyWith(
    LoginStateStatus? status,
    ValueGetter<String?>? error,
  ) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: error != null ? error() : this.errorMessage,
    );
  }
}

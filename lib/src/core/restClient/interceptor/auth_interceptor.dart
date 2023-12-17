import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dw_barbershop/src/core/constant/local_storage_key.dart';
import 'package:dw_barbershop/src/core/ui/barbershop_nav_global_key.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final RequestOptions(:headers, :extra) = options;

    const authHeaderKey = 'Authorization';
    headers.remove(authHeaderKey);
    headers.remove(HttpHeaders.authorizationHeader);
    if (extra case {'DIO_AUTH_KEY': true}) {
      final sp = await SharedPreferences.getInstance();
      final token = sp.getString(LocalStorageKeys.accessToken);

      headers.addAll({authHeaderKey: 'Bearer ${token}'});
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final DioException(requestOptions: RequestOptions(:extra), :response) = err;

    if (extra case {'DIO_AUTH_KEY': true}) {
      if (response != null && response.statusCode == HttpStatus.forbidden) {
        Navigator.of(
          BarbershopNavGlobalKey.instance.navKey.currentContext!,
        ).pushNamedAndRemoveUntil('/auth/login', ((route) => false));
      }
    }
    // loop
    handler.reject(err);
  }
}

import 'package:dio/dio.dart';
import 'package:dw_barbershop/src/core/constant/local_storage_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final RequestOptions(:headers, :extra) = options;

    const authHeaderKey = 'Authorization';
    headers.remove(authHeaderKey);
    if (extra case {'DIO_AUTH_KEY': true}) {
      final sp = await SharedPreferences.getInstance();
      final token = sp.getString(LocalStorageKeys.accessToken);

      headers.addAll({authHeaderKey: 'Bearer ${token}'});
    }

    handler.next(options);
  }
}

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../local/local_storage.dart';
import 'dio_interceptors.dart';


class DioClient {
  late final Dio dio;
  DioClient() : dio = Dio(
    BaseOptions(
      baseUrl: 'https://direct-service-new.herokuapp.com',
      connectTimeout: 60000, receiveTimeout: 60000,
      sendTimeout: 60000, responseType: ResponseType.json,
    ),)..interceptors.addAll([
    AuthorizationInterceptor(),
    LoggerInterceptor(),
  ]);
}

class AuthorizationInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async{
    Get.put<LocalCachedData>(await LocalCachedData.create());
    String? token = await LocalCachedData.instance.getAuthToken();
    if (token != null && token.isNotEmpty) {
      options.headers["Authorization"] = "Bearer $token";
    }
    options.headers["Accept"] = "application/json";
    options.headers["Content-Type"] = "application/json";
    super.onRequest(options, handler);
  }
}
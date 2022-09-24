import 'package:dio/dio.dart';
import '../../dio/dio_network_client.dart';

class UserDetailsServices {
  Future<Response> getUserDetails() async{
    final response = await DioClient().dio.get("/api/v1/driver/me");
    return response;
  }
}
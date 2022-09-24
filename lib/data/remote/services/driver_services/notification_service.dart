import 'package:dio/dio.dart';
import '../../dio/dio_network_client.dart';

class NotificationServices{
  Future<Response> getNotification() async{
    final response = await DioClient().dio.get("/api/v1/driver/notifications");
    return response;
  }
}
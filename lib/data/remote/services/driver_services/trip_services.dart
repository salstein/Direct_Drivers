import 'package:dio/dio.dart';
import '../../dio/dio_network_client.dart';

class TripServices{
  Future<Response> getTrip() async{
    final response = await DioClient().dio.get("/api/v1/driver/trips");
    return response;
  }

  Future<Response> pickUpPatient({required String tripID}) async {
    final response = await DioClient().dio.post("/api/v1/driver/pickup/$tripID");
    return response;
  }

  Future<Response> dropOffPatient({required String tripID}) async {
    final response = await DioClient().dio.post("/api/v1/driver/dropoff/$tripID}");
    return response;
  }
}
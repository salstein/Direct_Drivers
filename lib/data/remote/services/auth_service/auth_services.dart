import 'dart:convert';
import 'package:dio/dio.dart';
import '../../dio/dio_network_client.dart';

class AuthServices{

  Future<Response> signUp({required String phoneNumber, required String firstName, required String lastName, required String password}) async {
    var postBody = jsonEncode({
      'phone': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
      'password': password,
    });
    final response = await DioClient().dio.post("/api/v1/driver", data: postBody);
    return response;
  }

  Future<Response> signIn({required String phone, required String password}) async {
    var postBody = jsonEncode({
      'phone': phone,
      'password': password
    });
    final response = await DioClient().dio.post("/api/v1/driver/login", data: postBody);
    return response;
  }

  Future<Response> verifyStaff({required String address, required String country,
    required String state, required String firstName, required String lastName, required String lga}) async {
    var postBody = jsonEncode({
      "address": address,
      "country": country,
      "state": state,
      "firstName": firstName,
      "lastName": lastName,
      "lga": lga,
      // "phone" : phoneNumber
    });
    final response = await DioClient().dio.patch("/api/v1/driver/profile", data: postBody);
    return response;
  }

  Future<Response> verifyRegistrationOtp({required String otp}) async {
    var postBody = jsonEncode({
      "otp": otp,
    });
    final response = await DioClient().dio.post("/api/v1/driver/verify", data: postBody);
    return response;
  }
}
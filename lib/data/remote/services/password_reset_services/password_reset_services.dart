import 'dart:convert';
import 'package:dio/dio.dart';
import '../../dio/dio_network_client.dart';

class PasswordResetServices{

  Future<Response> forgotPassword({required String phone}) async {
    //var phoneNum = phone.startsWith("0") ? "234${phone.substring(1)}" : phone;
    var postBody = jsonEncode({
      "phone": phone
    });
    final response = await DioClient().dio.post("/api/v1/driver/forgot-password", data: postBody);
    return response;
  }

  Future<Response> verifyPasswordResetOtp({required String phone, required String otp}) async {
    var postBody = jsonEncode({
      "phone": phone,
      "otp": otp
    });
    final response = await DioClient().dio.post("/api/v1/driver/forgot-password/verify", data: postBody);
    return response;
  }

  Future<Response> resetPassword({required String newPassword}) async {
    var postBody = jsonEncode({
      'password': newPassword
    });
    final response = await DioClient().dio.post("/api/v1/driver/password", data: postBody);
    return response;
  }
}
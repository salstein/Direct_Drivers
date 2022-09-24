import 'dart:convert';
import 'package:dio/dio.dart';
import '../../dio/dio_network_client.dart';

class AccountServices{
  Future<Response> updateAccountInformation({required String firstName, required String lastName, required String phoneNumber}) async {
    var postBody = jsonEncode({
      'firstName': firstName,
      'lastName': lastName,
      'phone': phoneNumber,
    });
    final response = await DioClient().dio.patch("/api/v1/driver/basic", data: postBody);
    return response;
  }

}
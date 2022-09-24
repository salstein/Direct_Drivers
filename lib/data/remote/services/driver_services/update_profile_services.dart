import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import '../../dio/dio_network_client.dart';

class UpdateProfileServices{
  Future<Response> uploadProfilePicture({XFile? imageFile}) async {
    var formData = FormData.fromMap({
      'profilePic': await MultipartFile.fromFile(imageFile!.path, filename: imageFile.path.split('/').last)
    });
    final response = await DioClient().dio.post('/api/v1/driver/profile-pic', data: formData);
    return response;
  }

  Future<Response> updateProfile({ required String phoneNumber, required String firstName, required String lastName}) async {
    var postBody = jsonEncode({
      'phone': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
    });
    final response = await DioClient().dio.post("/api/v1/driver/profile-about", data: postBody);
    return response;
  }

  Future<Response> resetPassword({
    required String oldPassword, required String newPassword
  }) async {
    var postBody = jsonEncode({
      'oldPassword': oldPassword,
      'password': newPassword
    });
    final response = await DioClient().dio.patch("/api/v1/driver/password", data: postBody);
    return response;
  }
}
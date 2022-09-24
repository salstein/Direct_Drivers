import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import '../../services/driver_services/update_profile_services.dart';

class UpdateProfileRepository{
  final UpdateProfileServices _updateProfileServices;
  UpdateProfileRepository(this._updateProfileServices);
  Future<Response> uploadProfilePicture({XFile? imageFile}) => _updateProfileServices.uploadProfilePicture(imageFile: imageFile);
  Future<Response> updateProfile({required String phoneNumber, required String firstName, required String lastName}) => _updateProfileServices.updateProfile(phoneNumber: phoneNumber, firstName: firstName, lastName: lastName);
  Future<Response> resetPassword({required String oldPassword, required String newPassword}) => _updateProfileServices.resetPassword(oldPassword: oldPassword, newPassword: newPassword);
}
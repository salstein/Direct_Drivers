import 'package:direct_drivers/data/remote/services/password_reset_services/password_reset_services.dart';
import 'package:dio/dio.dart';

class PasswordResetRepository {
  final PasswordResetServices _passwordResetServices;
  PasswordResetRepository(this._passwordResetServices);
  Future<Response> forgotPassword({required String phone}) => _passwordResetServices.forgotPassword(phone: phone);
  Future<Response> verifyPasswordResetOtp({required String phone, required String otp}) => _passwordResetServices.verifyPasswordResetOtp(phone: phone, otp: otp);
  Future<Response> resetPassword({required String newPassword}) => _passwordResetServices.resetPassword(newPassword: newPassword);
}
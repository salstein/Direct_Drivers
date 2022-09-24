import 'package:direct_drivers/data/models/reset_password_otp_response_data.dart';
import 'package:direct_drivers/data/remote/repositories/password_reset_repository/password_reset_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../app/constants/http_status/http_status.dart';
import '../../app/constants/strings/strings.dart';
import '../../core/use_cases/use_cases.dart';
import '../../data/remote/dio/dio_data_state.dart';
import '../../data/remote/dio/dio_error_handling.dart';
import 'dart:developer';

class VerifyResetPasswordOtp implements useCase<DataState<ResetPasswordOtpResponseData>, Param> {
  final PasswordResetRepository _passwordResetRepository;

  VerifyResetPasswordOtp(this._passwordResetRepository);

  @override
  Future<DataState<ResetPasswordOtpResponseData>> execute({required Param params}) async{
    try {
      final response = await _passwordResetRepository.verifyPasswordResetOtp(phone: params.phone!, otp: params.otp!);
      if (response.statusCode == HttpResponseStatus.ok || response.statusCode == HttpResponseStatus.success) {
      return DataSuccess(ResetPasswordOtpResponseData.fromJson(response.data));
      }
      return DataFailed(response.statusMessage);
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      if (kDebugMode) {
        log(errorMessage);
      }
      return DataFailed(err.response?.data[Strings.error].toString() ?? errorMessage);
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      return DataFailed(err.toString());
    }
  }

}

class Param{
  final String? phone;
  final String? otp;
  Param(this.phone,this.otp);
}
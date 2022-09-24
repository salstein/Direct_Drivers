import 'package:direct_drivers/data/remote/repositories/password_reset_repository/password_reset_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../app/constants/http_status/http_status.dart';
import '../../app/constants/strings/strings.dart';
import '../../core/use_cases/use_cases.dart';
import '../../data/remote/dio/dio_data_state.dart';
import '../../data/remote/dio/dio_error_handling.dart';

class ForgotPasswordRepository implements useCase<DataState<Response>, Param> {
  final PasswordResetRepository _passwordResetRepository;

  ForgotPasswordRepository(this._passwordResetRepository);

  @override
  Future<DataState<Response>> execute({required Param params}) async{
    try {
      final response = await _passwordResetRepository.forgotPassword(phone: params.phone!);
      if (response.statusCode == HttpResponseStatus.ok || response.statusCode == HttpResponseStatus.success) {;
      return DataSuccess(response);
      }
      return DataFailed(response.statusMessage);
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      if (kDebugMode) {
        print(errorMessage);
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
  Param(this.phone);
}
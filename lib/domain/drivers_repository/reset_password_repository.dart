import 'package:dio/dio.dart';
import 'package:direct_drivers/data/remote/dio/dio_data_state.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/use_cases/use_cases.dart';
import '../../../../data/remote/dio/dio_error_handling.dart';
import '../../app/constants/http_status/http_status.dart';
import '../../app/constants/strings/strings.dart';
import '../../data/remote/repositories/driver_repository/update_profile_repository.dart';

class ResetPassword implements useCase<DataState<Response>, ResetPasswordParam> {
  final UpdateProfileRepository _updateProfileRepository;

  ResetPassword(this._updateProfileRepository);

  @override
  Future<DataState<Response>> execute({required ResetPasswordParam params}) async{
    try {
      final response = await _updateProfileRepository.resetPassword(oldPassword: params.olpPassword!, newPassword: params.newPassword!);
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

class ResetPasswordParam{
  final String? olpPassword;
  final String? newPassword;
  ResetPasswordParam(this.olpPassword,this.newPassword);
}


import 'package:dio/dio.dart';
import 'package:direct_drivers/data/remote/dio/dio_data_state.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/use_cases/use_cases.dart';
import '../../../../data/remote/dio/dio_error_handling.dart';
import '../../app/constants/http_status/http_status.dart';
import '../../app/constants/strings/strings.dart';
import '../../data/remote/repositories/driver_repository/update_profile_repository.dart';

class UpdateProfile implements useCase<DataState<Response>, UpdateProfileParam> {
  final UpdateProfileRepository _updateProfileRepository;

  UpdateProfile(this._updateProfileRepository);

  @override
  Future<DataState<Response>> execute({required UpdateProfileParam params}) async{
    try {
      final response = await _updateProfileRepository.updateProfile(phoneNumber: params.phone!, firstName: params.firstName!, lastName: params.lastName!);
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

class UpdateProfileParam{
  final String? firstName;
  final String? lastName;
  final String? phone;

  UpdateProfileParam(this.firstName,this.lastName, this.phone);
}


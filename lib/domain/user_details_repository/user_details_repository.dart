import 'package:dio/dio.dart';
import 'package:direct_drivers/app/constants/http_status/http_status.dart';
import 'package:direct_drivers/data/remote/dio/dio_data_state.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/use_cases/use_cases.dart';
import '../../../../data/remote/dio/dio_error_handling.dart';
import '../../app/constants/strings/strings.dart';
import '../../data/models/driver_profile_data.dart';
import '../../data/remote/repositories/user_details_repository/user_details_repository.dart';

class GetUserDetails implements noParamUseCases<DataState<DriverProfileData>> {
  final UserDetailRepository _userDetailRepository;

  GetUserDetails(this._userDetailRepository);

  Future<DataState<DriverProfileData>> noParamCall() async{
    try {
      final response = await _userDetailRepository.getUserDetails();
      if (response.statusCode == HttpResponseStatus.ok || response.statusCode == HttpResponseStatus.success) {;
      return DataSuccess(DriverProfileData.fromJson(response.data));
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
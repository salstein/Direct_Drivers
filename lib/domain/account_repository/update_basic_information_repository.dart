import 'package:direct_drivers/app/constants/strings/strings.dart';
import 'package:direct_drivers/core/use_cases/use_cases.dart';
import 'package:dio/dio.dart';
import 'package:direct_drivers/data/remote/repositories/account_repository/account_repository.dart';
import 'package:flutter/foundation.dart';
import '../../app/constants/http_status/http_status.dart';
import '../../data/remote/dio/dio_data_state.dart';
import '../../data/remote/dio/dio_error_handling.dart';

class UpdateBasicInformation extends useCase<DataState<Response>, Param> {
  final AccountRepository _accountRepository;
  UpdateBasicInformation(this._accountRepository);
  @override
  Future<DataState<Response>> execute({required params}) async{
    try{
      final response = await _accountRepository.updateAccountInformation(firstName: params.firstName!, lastName: params.lastName!, phoneNumber: params.phone!);
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
  final String? firstName;
  final String? lastName;
  final String? phone;
  Param(this.firstName, this.lastName, this.phone);
}
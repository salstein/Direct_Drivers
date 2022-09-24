import 'package:dio/dio.dart';
import 'package:direct_drivers/app/constants/http_status/http_status.dart';
import 'package:direct_drivers/data/models/sign_in_model.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/use_cases/use_cases.dart';
import '../../../../data/remote/dio/dio_data_state.dart';
import '../../../../data/remote/dio/dio_error_handling.dart';
import '../../../../data/remote/repositories/auth_repository/auth_repository.dart';
import '../../app/constants/strings/strings.dart';

class SignUpUser implements useCase<DataState<SignUpResponseModel>, SignUpParam> {
  final AuthRepository _authRepository;
  SignUpUser(this._authRepository);

  @override
  Future<DataState<SignUpResponseModel>> execute({required SignUpParam params}) async{
    try {
      final response = await _authRepository.signUp(firstName: params.firstName!, lastName: params.lastName!, phoneNumber: params.phone!, password: params.password!);
      if (response.statusCode == HttpResponseStatus.success || response.statusCode == HttpResponseStatus.ok) {
      return DataSuccess(SignUpResponseModel.fromJson(response.data));
      }
      return DataFailed(response.statusMessage);
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      if (kDebugMode) {
        print(err);
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

class SignUpParam{
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? password;

  SignUpParam(this.phone, this.password, this.firstName, this.lastName);
}
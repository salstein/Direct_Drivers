import 'package:dio/dio.dart';
import '../../services/auth_service/auth_services.dart';

class AuthRepository {
  final AuthServices _authServices;
  AuthRepository(this._authServices);

  Future<Response> signUp({required String phoneNumber, required String firstName, required String lastName, required String password}) => _authServices.signUp(phoneNumber: phoneNumber, firstName: firstName, lastName: lastName, password: password);

  Future<Response> signIn({required String phone, required String password}) => _authServices.signIn(phone: phone, password: password);

  Future<Response> verifyDriver({required String address, required String country, required String state,
    required String firstName, required String lastName, required String lga}) => _authServices.verifyStaff(address: address, country: country, state: state, firstName: firstName,
      lastName: lastName, lga: lga);

  Future<Response> verifyRegistrationOtp({required String otp}) => _authServices.verifyRegistrationOtp(otp: otp);

}
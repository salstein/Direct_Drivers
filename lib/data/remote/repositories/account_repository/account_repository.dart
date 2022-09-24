import 'package:direct_drivers/data/remote/services/account_services/account_services.dart';
import 'package:dio/dio.dart';

class AccountRepository{
  final AccountServices _accountServices;
  AccountRepository(this._accountServices);
  Future<Response> updateAccountInformation({
    required String firstName,
    required String lastName,
    required String phoneNumber}) => _accountServices.updateAccountInformation(
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber
  );
}
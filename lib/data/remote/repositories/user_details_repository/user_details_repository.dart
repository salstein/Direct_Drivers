import 'package:dio/dio.dart';
import 'package:direct_drivers/data/remote/services/user_details_services/user_details_services.dart';

class UserDetailRepository {
  final UserDetailsServices _userDetailsServices;
  UserDetailRepository(this._userDetailsServices);
  Future<Response> getUserDetails() => _userDetailsServices.getUserDetails();
}
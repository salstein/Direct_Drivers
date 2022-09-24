import 'dart:convert';
import 'package:direct_drivers/app/constants/strings/strings.dart';
import 'package:direct_drivers/data/models/driver_profile_data.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LocalCachedData{
  final SharedPreferences _prefs;
  LocalCachedData._(this._prefs);
  static Future<LocalCachedData> create() async => LocalCachedData._(await SharedPreferences.getInstance());
  static LocalCachedData get instance => Get.find<LocalCachedData>();

  Future<String?> getAuthToken() async {
    String? token = _prefs.getString(Strings.token);
    return token;
  }

  Future<void> cacheAuthToken({required String? token}) async {
    _prefs.setString(Strings.token, token!);
  }

  Future<void> cachedRegFirstName({required String? firstName}) async {
    _prefs.setString(Strings.firstName, firstName!);
  }

  Future<void> cachedRegLastName({required String? lastName}) async {
    _prefs.setString(Strings.lastName, lastName!);
  }

  Future<String?> getRegFirstName() async {
    String? firstName = _prefs.getString(Strings.firstName);
    return firstName;
  }

  Future<String?> getRegLastName() async {
    String? lastName = _prefs.getString(Strings.lastName);
    return lastName;
  }

  Future<void> cachePassword({required String? password}) async {
    _prefs.setString(Strings.password, password!);
  }

  Future<String?> getPassword() async {
    String? password = _prefs.getString(Strings.password);
    return password;
  }

  Future<void> cacheDriverProfileData({required DriverProfileData driverProfileData }) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(Strings.driverProfile, json.encode(driverProfileData.toJson()));
  }

  Future<DriverProfileData?> getDriverProfileData() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String? userData = sharedPreferences.getString(Strings.driverProfile);
    return userData == null ? null : DriverProfileData.fromJson(jsonDecode(userData));
  }

  Future<bool> getLoginStatus() async {
    bool? userData = _prefs.getBool(Strings.checkLoginStatus);
    return userData ?? false;
  }

  Future<void> cacheLoginStatus({required bool isLoggedIn}) async {
    _prefs.setBool(Strings.checkLoginStatus, isLoggedIn);
  }

// Future<void> saveUserDetails({required UserDetails userDetails}) async {
//   final sharedPreferences = await SharedPreferences.getInstance();
//   sharedPreferences.setString("saveUserDetails", jsonEncode(userDetails.toJson()));
// }
// Future<UserDetails> fetchUserDetails() async {
//   final sharedPreferences = await SharedPreferences.getInstance();
//   String? userData = sharedPreferences.getString("saveUserDetails");
//   return UserDetails.fromJson(jsonDecode(userData!));
// }

}
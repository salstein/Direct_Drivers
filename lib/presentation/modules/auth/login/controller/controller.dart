import 'package:direct_drivers/data/models/driver_profile_data.dart';
import 'package:direct_drivers/data/remote/dio/dio_data_state.dart';
import 'package:direct_drivers/data/remote/repositories/auth_repository/auth_repository.dart';
import 'package:direct_drivers/data/remote/repositories/user_details_repository/user_details_repository.dart';
import 'package:direct_drivers/data/remote/services/auth_service/auth_services.dart';
import 'package:direct_drivers/data/remote/services/user_details_services/user_details_services.dart';
import 'package:direct_drivers/domain/user_details_repository/user_details_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/state/view_state.dart';
import '../../../../../data/local/local_storage.dart';
import '../../../../../domain/auth_repository/signin_repository.dart';
import 'dart:developer';


class LoginController extends GetxController{
  final _signIn = Get.put(SignInUser(AuthRepository(AuthServices())));
  final _getUserDetails = Get.put(GetUserDetails(UserDetailRepository(UserDetailsServices())));

  //Keys
  final scaffoldKey = GlobalKey <ScaffoldState>();
  final formKey = GlobalKey <FormState>();

  //Form Controllers
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();

  //Variables
  bool? networkState;
  String? errorMessage;
  bool togglePassword = true;
  String? userPassword;

  //Initialize State
  ViewState<DriverProfileData> viewState = ViewState(state: ResponseState.EMPTY);

  void _setViewState(ViewState<DriverProfileData> viewState) {
    this.viewState = viewState;
  }

  void togglePasswordVisibility(){
    togglePassword = !togglePassword;
    update();
  }


  Future <void> signAndSaveUserData() async {
    await signIn().whenComplete(() async {
      await _getUserDetails.noParamCall().then((value) async {
        if(value is DataSuccess || value.data?.data != null){
          await LocalCachedData.instance.cacheDriverProfileData(driverProfileData: value.data!);
          await LocalCachedData.instance.cacheLoginStatus(isLoggedIn: true).whenComplete(() async {
            await LocalCachedData.instance.cachePassword(password: userPassword);
            _setViewState(ViewState.complete(value.data!));
            update();
          });
        }
        if (value is DataFailed || value.data?.data == null) {
          if (kDebugMode) {
            print(value.error.toString());
          }
          errorMessage = value.error.toString();
          _setViewState(ViewState.error(value.error.toString()));
          update();
        }
      });
    });
  }

  Future<void> signIn()async{
      await _signIn.execute(params: SignInParam(phoneNumberController.text, passwordController.text)).then((value) async {
        if(value is DataSuccess || value.data?.data != null) {
          final token = value.data?.headers["X-Auth-Token"]?.single;
          await LocalCachedData.instance.cacheAuthToken(token: token);
        }
        if (value is DataFailed || value.data?.data == null) {
          if (kDebugMode) {
            print(value.error.toString());
          }
          errorMessage = value.error.toString();
          _setViewState(ViewState.error(value.error.toString()));
          update();
        }}
      );
  }


  Future<void> onInitializeLocalStorage() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    super.onInit();
  }

  @override
  void onInit() {
    onInitializeLocalStorage();
    super.onInit();
  }
}
import 'package:direct_drivers/data/remote/repositories/driver_repository/update_profile_repository.dart';
import 'package:direct_drivers/data/remote/services/driver_services/update_profile_services.dart';
import 'package:direct_drivers/domain/drivers_repository/reset_password_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../../core/state/view_state.dart';
import '../../../../../data/local/local_storage.dart';
import '../../../../../data/models/driver_profile_data.dart';
import '../../../../../data/remote/dio/dio_data_state.dart';
import 'package:dio/dio.dart' as dio;

class PasswordResetController extends GetxController{
  final _resetPassword = ResetPassword(UpdateProfileRepository(UpdateProfileServices()));

  //Keys
  final scaffoldKey = GlobalKey <ScaffoldState>();
  final formKey = GlobalKey <FormState>();

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

  //Variables
  String? errorMessage;
  bool togglePassword = true;
  String? oldPassword;
  DriverProfileData? driverProfileData;

  ViewState<dio.Response> viewState = ViewState(state: ResponseState.EMPTY);
  void _setViewState(ViewState<dio.Response> viewState) {
    this.viewState = viewState;
  }

  void togglePasswordVisibility(){
    togglePassword = !togglePassword;
    update();
  }


  Future<void> onInitializeLocalStorage() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    super.onInit();
    await LocalCachedData.instance.getDriverProfileData().then((value) async{
      driverProfileData = value;
      await LocalCachedData.instance.getPassword().then((value) {
        oldPassword = value;
      });
      update();
    });
  }


  Future<void> resetPassword()async{
    await _resetPassword.execute(params: ResetPasswordParam(oldPasswordController.text, newPasswordController.text)).then((value) {
      if(value is DataSuccess) {
        _setViewState(ViewState.complete(value.data?.data));
        update();
      }
      if (value is DataFailed) {
        if (kDebugMode) {
          print(value.error.toString());
        }
        errorMessage = value.error.toString();
        _setViewState(ViewState.error(value.error.toString()));
        update();
      }}
    );
  }

  @override
  void onInit() {
    onInitializeLocalStorage();
    super.onInit();
  }
}
import 'package:direct_drivers/data/remote/repositories/password_reset_repository/password_reset_repository.dart';
import 'package:direct_drivers/data/remote/services/password_reset_services/password_reset_services.dart';
import 'package:direct_drivers/domain/password_reset_repository/reset_password_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import '../../../../../core/state/view_state.dart';
import '../../../../../data/remote/dio/dio_data_state.dart';

class ResetPasswordController extends GetxController{
  final _resetPassword = Get.put(ResetPassword(PasswordResetRepository(PasswordResetServices())));

  //FormField
  final newPasswordController = TextEditingController();

  //Keys
  final scaffoldKey = GlobalKey <ScaffoldState>();
  final formKey = GlobalKey <FormState>();

  bool togglePassword = true;
  String? errorMessage;

  void togglePasswordVisibility(){
    togglePassword = !togglePassword;
    update();
  }


  ViewState<dio.Response> viewState = ViewState(state: ResponseState.EMPTY);

  void _setViewState(ViewState<dio.Response> viewState) {
    this.viewState = viewState;
  }

  Future<void> resetPassword()async{
    await _resetPassword.execute(params: Param(newPasswordController.text)).then((value) async {
      if(value is DataSuccess || value.data?.data != null) {
            _setViewState(ViewState.complete(value.data!));
            update();
      }
      if (value is DataFailed || value.data?.data == null) {
        if (kDebugMode) {
          print(value.error);
        }
        errorMessage = value.error.toString();
        _setViewState(ViewState.error(value.error.toString()));
        update();
      }}
    );
  }
}
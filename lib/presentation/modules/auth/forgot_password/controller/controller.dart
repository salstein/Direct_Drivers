import 'package:direct_drivers/data/remote/repositories/password_reset_repository/password_reset_repository.dart';
import 'package:direct_drivers/data/remote/services/password_reset_services/password_reset_services.dart';
import 'package:direct_drivers/domain/password_reset_repository/forgot_password_repository.dart';
import 'package:direct_drivers/presentation/modules/auth/otp/controller/controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import '../../../../../core/state/view_state.dart';
import '../../../../../data/remote/dio/dio_data_state.dart';

class ForgotPasswordController extends GetxController{
  final _forgetPassword = Get.put(ForgotPasswordRepository(PasswordResetRepository(PasswordResetServices())));
  final otpController = Get.put(OtpController());

  //Keys
  final scaffoldKey = GlobalKey <ScaffoldState>();
  final formKey = GlobalKey <FormState>();

  //Form Controllers
  final phoneNumberController = TextEditingController();

  //Variables
  String? errorMessage;

  ViewState<dio.Response> viewState = ViewState(state: ResponseState.EMPTY);

  void _setViewState(ViewState<dio.Response> viewState) {
    this.viewState = viewState;
  }


  Future<void> forgotPassword()async{
    await _forgetPassword.execute(params: Param(phoneNumberController.text.trim())).then((value) async {
      if(value is DataSuccess || value.data?.data != null) {
        _setViewState(ViewState.complete(value.data!));
        update();
      }
      if (value is DataFailed || value.data?.data == null) {
        if (kDebugMode) {
          print(value.error);
        }
        errorMessage = value.error.toString();
        update();
        _setViewState(ViewState.error(value.error.toString()));
      }}
    );
  }
}
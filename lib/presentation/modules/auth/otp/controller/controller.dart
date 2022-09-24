import 'package:direct_drivers/core/routes/app_route.dart';
import 'package:direct_drivers/data/models/reset_password_otp_response_data.dart';
import 'package:direct_drivers/data/remote/repositories/password_reset_repository/password_reset_repository.dart';
import 'package:direct_drivers/data/remote/services/password_reset_services/password_reset_services.dart';
import 'package:direct_drivers/domain/auth_repository/otp_repository.dart';
import 'package:direct_drivers/domain/password_reset_repository/verify_reset_password_otp_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../../core/state/view_state.dart';
import '../../../../../data/local/local_storage.dart';
import '../../../../../data/remote/dio/dio_data_state.dart';
import '../../../../../data/remote/repositories/auth_repository/auth_repository.dart';
import '../../../../../data/remote/services/auth_service/auth_services.dart';
import 'package:dio/dio.dart' as dio;
import 'dart:developer';

class OtpController extends GetxController{
  final _verifyOtp = Get.put(VerifyOtp(AuthRepository(AuthServices())));
  final _verifyResetPasswordOtp = Get.put(VerifyResetPasswordOtp(PasswordResetRepository(PasswordResetServices())));

  //Keys
  final scaffoldKey = GlobalKey <ScaffoldState>();
  final formKey = GlobalKey <FormState>();

  //Form Controllers
  final otpController = TextEditingController();

  bool get fromResetPassword => Get.arguments == Routes.forgotPassword;

  //Variables
  String? errorMessage;
  String? phoneNumber;

  ViewState<dio.Response> viewState = ViewState(state: ResponseState.EMPTY);
  ViewState<ResetPasswordOtpResponseData> verifyForgotPasswordOtpViewState = ViewState(state: ResponseState.EMPTY);

  void _setViewState(ViewState<dio.Response> viewState) {
    this.viewState = viewState;
  }
  void _verifyForgotPasswordOtpSetViewState(ViewState<ResetPasswordOtpResponseData> viewState) {
    this.verifyForgotPasswordOtpViewState = viewState;
  }

  Future<void> verifyResetPasswordOtp()async{
    await _verifyResetPasswordOtp.execute(params: Param(phoneNumber!.trim(), otpController.text.trim())).then((value) async {
      log(value.toString());
      if(value is DataSuccess || value.data?.data != null) {
        final token = value.data?.data?.token;
        await LocalCachedData.instance.cacheAuthToken(token: token).whenComplete((){
          _verifyForgotPasswordOtpSetViewState(ViewState.complete(value.data!));
          update();
        });
      }
      if (value is DataFailed || value.data?.data == null) {
        if (kDebugMode) {
          print(value.error);
        }
        errorMessage = value.error.toString();
        _verifyForgotPasswordOtpSetViewState(ViewState.error(value.error.toString()));
        update();
      }}
    );
  }

  Future<void> verifyOtp()async{
      await _verifyOtp.execute(params: OtpParam(otpController.text)).then((value) {
        log(value.data.toString());
        if(value is DataSuccess || value.data != null) {
            _setViewState(ViewState.complete(value.data!));
            update();
        }
        if (value is DataFailed || value.data == null) {
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
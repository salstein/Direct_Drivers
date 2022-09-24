import 'package:direct_drivers/data/models/sign_in_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/state/view_state.dart';
import '../../../../../data/local/local_storage.dart';
import '../../../../../data/remote/dio/dio_data_state.dart';
import '../../../../../data/remote/repositories/auth_repository/auth_repository.dart';
import '../../../../../data/remote/services/auth_service/auth_services.dart';
import '../../../../../domain/auth_repository/signup_repository.dart';

class SignUpController extends GetxController{
  final _signUpUser = Get.put(SignUpUser(AuthRepository(AuthServices())));
  final formKeySignUp = GlobalKey <FormState>();
  final scaffoldKeySignUp = GlobalKey <ScaffoldState>();

  bool togglePassword = true;
  bool acceptTcs = false;
  String? errorMessage;
  String? firstName;
  String? lastName;

  //Form Controllers
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  void acceptTermAndConditions(){
      acceptTcs = !acceptTcs;
      update();
  }

  void togglePasswordVisibility(){
      togglePassword = !togglePassword;
      update();
  }

  ViewState<SignUpResponseModel> viewState = ViewState(state: ResponseState.EMPTY);

  void _setViewState(ViewState<SignUpResponseModel> viewState) {
    this.viewState = viewState;
  }

  Future<void> signUp()async{
      await _signUpUser.execute(params: SignUpParam(phoneNumberController.text, passwordController.text, firstNameController.text, lastNameController.text)).then((value) async {
        if(value is DataSuccess || value.data?.data != null) {
          final token = value.data?.data?.token;
          await LocalCachedData.instance.cacheAuthToken(token: token).whenComplete(() async {
            await LocalCachedData.instance.cachedRegFirstName(firstName: firstName).whenComplete(() async {
              await LocalCachedData.instance.cachedRegLastName(lastName: lastName).whenComplete((){
                _setViewState(ViewState.complete(value.data!));
                update();
              });
            });
          });
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
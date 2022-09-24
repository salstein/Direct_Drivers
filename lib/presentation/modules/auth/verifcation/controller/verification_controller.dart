import 'package:direct_drivers/app/constants/strings/strings.dart';
import 'package:direct_drivers/domain/auth_repository/driver_verification_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../../app/utils/nigerian_states_and_lga.dart';
import '../../../../../core/routes/app_route.dart';
import '../../../../../core/state/view_state.dart';
import '../../../../../data/local/local_storage.dart';
import '../../../../../data/remote/dio/dio_data_state.dart';
import '../../../../../data/remote/repositories/auth_repository/auth_repository.dart';
import '../../../../../data/remote/repositories/user_details_repository/user_details_repository.dart';
import '../../../../../data/remote/services/auth_service/auth_services.dart';
import 'package:dio/dio.dart' as dio;
import '../../../../../data/remote/services/user_details_services/user_details_services.dart';
import '../../../../../domain/user_details_repository/user_details_repository.dart';

class VerificationController extends GetxController{
  final _verifyDriver = Get.put(VerifyDriverInformation(AuthRepository(AuthServices())));
  final _getUserDetails = Get.put(GetUserDetails(UserDetailRepository(UserDetailsServices())));

  final formKeyStaffVerification = GlobalKey <FormState>();
  final scaffoldKeyStaffVerification = GlobalKey <ScaffoldState>();

  final addressController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  String? selectedCountry;

  bool get fromProfileUpdate => Get.arguments == Routes.account;

  List<String>? states;
  List<String> lga = [];
  String? selectedState;
  String? selectedLga;
  String? errorMessage;

  final List<String> _countries = ["Nigeria"];
  final List<String> _officeCountries = ["Nigeria"];
  final List<String> _role = ["Driver"];

  List<String> get role => _role;
  List<String> get officeCountries => _officeCountries;
  List<String> get countries => _countries;

  ViewState<dio.Response> viewState = ViewState(state: ResponseState.EMPTY);

  void _setViewState(ViewState<dio.Response> viewState) {
    this.viewState = viewState;
  }

  Future<void> staffVerification()async{
      await _verifyDriver.execute(params: VerificationParam(addressController.text.trim(), selectedCountry!.trim(),
          selectedState!.trim(), firstNameController.text.trim(),
        lastNameController.text.trim(), selectedLga!.trim(),
      )).then((value) async {
        if(value is DataSuccess || value.data?.data != null) {
          _setViewState(ViewState.complete(value.data!));
        }if (value is DataFailed || value.data?.data == null) {
          if (kDebugMode) {
            print(value.error);
          }errorMessage = value.error.toString();
          update();
          _setViewState(ViewState.error(value.error.toString()));
        }}
      );
  }

  Future<void> onInitializeLocalStorage() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    await LocalCachedData.instance.getRegFirstName().then((value) async {
      firstNameController.text = value!;
      update();
      await LocalCachedData.instance.getRegLastName().then((value) async {
        lastNameController.text = value!;
        update();
      });
    });
    super.onInit();
  }

  void refreshDriverData() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    super.onInit();
      await _getUserDetails.noParamCall().then((value) async{
        await LocalCachedData.instance.cacheDriverProfileData(driverProfileData: value.data!).then((value) async {
          await LocalCachedData.instance.getDriverProfileData().then((value){
            selectedState = value?.data?.state ?? Strings.emptyString;
            selectedCountry = value?.data?.country ?? Strings.emptyString;
            selectedLga = value?.data?.lga ?? Strings.emptyString;
            firstNameController.text =  value?.data?.firstName ?? Strings.emptyString;
            lastNameController.text =  value?.data?.lastName ?? Strings.emptyString;
            addressController.text = value?.data?.address ?? Strings.emptyString;
            states = GeneralHelper().getStates();
            lga = GeneralHelper().getStaLga(selectedState!);
            update();
          });
        });
      });
  }

  @override
  void onInit() {
    fromProfileUpdate == true ? refreshDriverData() :  onInitializeLocalStorage();
    states = GeneralHelper().getStates();
    super.onInit();
  }

  void selectLga(String? value){
    selectedLga = value;
    update();
  }
  selectState(String value){
    selectedState = value;
    selectedLga = null;
    lga = GeneralHelper().getStaLga(selectedState!);
    update();
  }

  void selectCountry(String? value){
    selectedCountry = value!;
    states = GeneralHelper().getStates();
    update();
  }
}
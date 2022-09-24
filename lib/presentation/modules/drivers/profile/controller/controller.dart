import 'package:direct_drivers/domain/drivers_repository/update_profile_repository.dart';
import 'package:direct_drivers/presentation/modules/drivers/home/controller/home_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/state/view_state.dart';
import '../../../../../data/local/local_storage.dart';
import '../../../../../data/models/driver_profile_data.dart';
import 'package:flutter/material.dart';
import '../../../../../data/remote/dio/dio_data_state.dart';
import '../../../../../data/remote/repositories/driver_repository/update_profile_repository.dart';
import '../../../../../data/remote/repositories/user_details_repository/user_details_repository.dart';
import '../../../../../data/remote/services/driver_services/update_profile_services.dart';
import '../../../../../data/remote/services/user_details_services/user_details_services.dart';
import '../../../../../domain/drivers_repository/profile_picture_repository.dart';
import '../../../../../domain/user_details_repository/user_details_repository.dart';

class ProfileController extends GetxController{
  final homeController = Get.put(HomeController());
  final _getUserDetails = Get.put(GetUserDetails(UserDetailRepository(UserDetailsServices())));
  final _uploadProfilePicture = Get.put(UploadProfilePicture(UpdateProfileRepository(UpdateProfileServices())));
  final _updateProfile = Get.put(UpdateProfile(UpdateProfileRepository(UpdateProfileServices())));

  DriverProfileData? driverProfileData;
  TextEditingController? firstNameController = TextEditingController();
  TextEditingController? lastNameController = TextEditingController();
  TextEditingController? phoneNumberController = TextEditingController();
  String? registeredPhoneNumber;
  final picker = ImagePicker();
  XFile? imageFile;
  String? errorMessage;
  bool? isUploadingProfilePicture;
  dynamic pickImageError;

  Future<void> onInitializeLocalStorage() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    super.onInit();
    await LocalCachedData.instance.getDriverProfileData().then((value){
      driverProfileData = value;
      registeredPhoneNumber = driverProfileData!.data!.phone;
      firstNameController?.text = driverProfileData!.data!.firstName!;
      lastNameController?.text = driverProfileData!.data!.lastName!;
      phoneNumberController?.text = driverProfileData!.data!.phone!;
      update();
    });
  }

  ViewState<DriverProfileData> viewState = ViewState(state: ResponseState.EMPTY);

  void _setViewState(ViewState<DriverProfileData> viewState) {
    this.viewState = viewState;
  }


  @override
  void onInit() {
    onInitializeLocalStorage();
    super.onInit();
  }

  ViewState<DriverProfileData> updateProfileViewState = ViewState(state: ResponseState.EMPTY);

  void _setUpdateProfileViewState(ViewState<DriverProfileData> viewState) {
    this.updateProfileViewState = viewState;
  }

  Future<void> updateProfile()async{
    await _updateProfile.execute(params: UpdateProfileParam(firstNameController!.text,
        lastNameController!.text, phoneNumberController!.text)).then((value) async {
      if(value is DataSuccess || value.data?.data != null) {
        await _getUserDetails.noParamCall().then((value) async {
          await LocalCachedData.instance.cacheDriverProfileData(driverProfileData: value.data!).whenComplete(() async {
            await LocalCachedData.instance.getDriverProfileData().then((value){
              firstNameController?.text = value!.data!.firstName!;
              lastNameController?.text = value!.data!.lastName!;
              phoneNumberController?.text = value!.data!.phone!;
              _setUpdateProfileViewState(ViewState.complete(value!));
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
        _setUpdateProfileViewState(ViewState.error(value.error.toString()));
        update();
      }}
    );
  }

  onUploadProfilePicture(ImageSource source) async {
    try {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        imageFile = pickedFile;
        isUploadingProfilePicture = true;
        update();
        await _uploadProfilePicture.execute(params: Param(imageFile)).then((value) async {
          if(value is DataSuccess || value.data?.data != null) {
            await _getUserDetails.noParamCall().then((value) async {
              await LocalCachedData.instance.cacheDriverProfileData(driverProfileData: value.data!).whenComplete(() async {
                await LocalCachedData.instance.getDriverProfileData().then((value){
                  homeController.driverProfileData = value;
                  isUploadingProfilePicture = false;
                  _setViewState(ViewState.complete(value!));
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
            update();
            _setViewState(ViewState.error(value.error.toString()));
          }}
        );
      }
    } catch (e) {
      pickImageError = e;
      isUploadingProfilePicture = false;
      update();
    }
  }

}
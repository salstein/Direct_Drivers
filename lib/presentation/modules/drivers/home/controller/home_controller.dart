import 'package:direct_drivers/data/models/driver_profile_data.dart';
import 'package:direct_drivers/data/remote/repositories/driver_repository/update_profile_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/state/view_state.dart';
import '../../../../../data/local/local_storage.dart';
import '../../../../../data/remote/dio/dio_data_state.dart';
import '../../../../../data/remote/repositories/user_details_repository/user_details_repository.dart';
import '../../../../../data/remote/services/driver_services/update_profile_services.dart';
import '../../../../../data/remote/services/user_details_services/user_details_services.dart';
import '../../../../../domain/drivers_repository/profile_picture_repository.dart';
import '../../../../../domain/user_details_repository/user_details_repository.dart';


class HomeController extends GetxController{
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final _uploadProfilePicture = Get.put(UploadProfilePicture(UpdateProfileRepository(UpdateProfileServices())));
  final _getUserDetails = Get.put(GetUserDetails(UserDetailRepository(UserDetailsServices())));

  //Variable and object Initialization
  final picker = ImagePicker();
  XFile? imageFile;
  String? errorMessage;
  DriverProfileData? driverProfileData;
  bool? isUploadingProfilePicture;
  dynamic pickImageError;
  var km;

  Future<void> onInitializeLocalStorage() async {
      Get.put<LocalCachedData>(await LocalCachedData.create());
      super.onInit();
      await LocalCachedData.instance.getDriverProfileData().then((value){
        driverProfileData = value;
        update();
      });
    }


  ViewState<DriverProfileData> viewState = ViewState(state: ResponseState.EMPTY);

  void _setViewState(ViewState<DriverProfileData> viewState) {
    this.viewState = viewState;
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
                   driverProfileData = value;
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

  @override
  void onInit() {
    onInitializeLocalStorage();
    super.onInit();
  }
}


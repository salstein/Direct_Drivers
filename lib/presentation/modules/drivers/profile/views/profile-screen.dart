import 'package:direct_drivers/app/utils/validator.dart';
import 'package:direct_drivers/core/routes/app_route.dart';
import 'package:direct_drivers/presentation/modules/drivers/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../app/constants/strings/strings.dart';
import '../../../../../app/utils/color_palette.dart';
import '../../../../../app/utils/dummy_data.dart';
import '../../../../../app/utils/flush_bar_loader.dart';
import '../../../../../app/utils/loading_dialog.dart';
import '../../../../../app/widgets/custom_form_field.dart';
import '../../../../../core/state/view_state.dart';
import '../controller/controller.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  Future<bool> _onWillPop(BuildContext? context, ProfileController? controller) async {
    Widget cancelButton = TextButton(
      child: const Text("NO", style: TextStyle(color: kPrimaryColor),),
      onPressed:  () {
        Get.back();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("YES", style: TextStyle(color: kPrimaryColor),),
      onPressed:  () {
        Get.back();
        updateProfile(context!, controller!);
      },
    );
    AlertDialog alert = AlertDialog(
      title: const Text("Update", style: TextStyle(color: kPrimaryColor, fontSize: 20),),
      content: const Text("If you change your phone number, you may be forced to sign In again. Do you wish to continue?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    return (await showDialog(
      context: context!,
      builder: (context) => alert,
    )) ?? false;
  }

  void updateProfile(BuildContext context, ProfileController controller)async{
    ProgressDialogHelper().loadingState;
    await controller.updateProfile();
    if(controller.updateProfileViewState.state == ResponseState.COMPLETE){
      ProgressDialogHelper().loadStateTerminated;
      controller.phoneNumberController?.text != controller.registeredPhoneNumber ? Get.offAllNamed(Routes.onBoarding) : Get.offAllNamed(Routes.home);
      FlushBarHelper(context, Strings.updateSuccessMsg).showSuccessBar;
    }else if(controller.updateProfileViewState.state == ResponseState.ERROR){
      ProgressDialogHelper().loadStateTerminated;
      FlushBarHelper(context, controller.errorMessage == Strings.emptyString ? Strings.internalServerError : Strings.errorOccurred).showErrorBar;
    }
  }

  void uploadProfilePicture(BuildContext context, ProfileController controller, ImageSource source)async{
    ProgressDialogHelper().loadingState;
    await controller.onUploadProfilePicture(source);
    if(controller.viewState.state == ResponseState.COMPLETE){
      ProgressDialogHelper().loadStateTerminated;
      Get.offAllNamed(Routes.home);
      FlushBarHelper(context, Strings.photoUploadSuccessMsg).showSuccessBar;
    }else if(controller.viewState.state == ResponseState.ERROR){
      ProgressDialogHelper().loadStateTerminated;
      FlushBarHelper(context, controller.errorMessage == Strings.emptyString ? Strings.internalServerError : Strings.errorOccurred).showErrorBar;
    }
  }

  _showImagePickerDialog(){
    showDialog(barrierDismissible: true, context: context, builder: (context){
      return GetBuilder<ProfileController>(
          init: ProfileController(),
          builder: (controller){
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),),
              child: Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(fixedSize: const Size(180, 45)),
                      onPressed: () {
                        Get.back();
                        uploadProfilePicture(context, controller, ImageSource.gallery);
                      },
                      child: const Text("Open Gallery"),),
                    const SizedBox(height: 20,),
                    OutlinedButton(
                      onPressed: () {
                        Get.back();
                        uploadProfilePicture(context, controller, ImageSource.camera);
                      },
                      style: OutlinedButton.styleFrom(
                        primary: kPrimaryColor, side: const BorderSide(color: kPrimaryColor), fixedSize: const Size(180, 45),),
                      child: const Text("Take a photo"),
                    ),
                  ],
                ),
              ),
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black,),
        onPressed: (){
          Get.back();
        },),),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24,10,24,24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Profile", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
            const SizedBox(height: 26,),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    GetBuilder<HomeController>(
                      init: HomeController(),
                        builder: (controller){
                      return Container(height: 64, width: 64,
                          decoration: BoxDecoration(shape: BoxShape.circle,
                              color: Colors.grey.withOpacity(0.15),
                              image: DecorationImage(
                                image: NetworkImage(controller.driverProfileData?.data?.avatar ?? DummyData.defaultImageUrl),
                                fit: BoxFit.fill,
                              )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: controller.isUploadingProfilePicture == true ? CircularProgressIndicator(color: Colors.white, strokeWidth: 2,)
                                : controller.isUploadingProfilePicture == false? null : null,
                          )
                      );
                    }),
                    const SizedBox(height: 10,),
                    InkWell(
                      onTap: (){
                        _showImagePickerDialog();
                      },
                      child: const Text("Change Photo", style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline, fontSize: 15),),),
                    const SizedBox(height: 48),
                    Form(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("First Name", style: TextStyle(color: Colors.black, fontSize: 14),),
                          const SizedBox(height: 12,),
                          GetBuilder<ProfileController>(
                            init: ProfileController(),
                              builder: (controller){
                            return FormFieldWidget(
                              controller: controller.firstNameController,
                              validator: Validator.isName,
                            );
                          }),
                          const SizedBox(height: 24,),
                          const Text("Last Name", style: TextStyle(color: Colors.black, fontSize: 14),),
                          const SizedBox(height: 12,),
                          GetBuilder<ProfileController>(
                            init: ProfileController(),
                              builder: (controller){
                            return FormFieldWidget(
                              controller: controller.lastNameController,
                              validator: Validator.isName,
                            );
                          }),
                          const SizedBox(height: 24,),
                          const Text("Phone Number", style: TextStyle(color: Colors.black, fontSize: 14),),
                          const SizedBox(height: 12,),
                          GetBuilder<ProfileController>(
                              init: ProfileController(),
                              builder: (controller){
                                return FormFieldWidget(
                                  controller: controller.phoneNumberController,
                                  validator: Validator.isPhone,
                                );
                              }),
                          const SizedBox(height: 48,),
                          GetBuilder<ProfileController>(
                            init: ProfileController(),
                              builder: (controller){
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                fixedSize: const Size(double.maxFinite, 48),
                              ),
                              child: const Text("Update", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                              onPressed: (){_onWillPop(context, controller);
                              },
                            );
                          })
                        ],
                      ),)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


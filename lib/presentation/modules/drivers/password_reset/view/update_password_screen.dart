import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../app/constants/strings/strings.dart';
import '../../../../../app/utils/color_palette.dart';
import '../../../../../app/utils/flush_bar_loader.dart';
import '../../../../../app/utils/loading_dialog.dart';
import '../../../../../app/utils/validator.dart';
import '../../../../../app/widgets/custom_form_field.dart';
import '../../../../../core/routes/app_route.dart';
import '../../../../../core/state/view_state.dart';
import '../controller/controller.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({Key? key}) : super(key: key);

  @override
  _UpdatePasswordState createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {

  Future<bool> _onWillPop(PasswordResetController controller) async {
    Widget cancelButton = TextButton(
      child: const Text("NO", style: TextStyle(color: kPrimaryColor),),
      onPressed:  () {
        Get.back();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("YES", style: TextStyle(color: kPrimaryColor),),
      onPressed:  () {
        if(controller.oldPasswordController.text != controller.oldPassword){
          Get.back();
          FlushBarHelper(context, Strings.validateOldPasswordMsg).showErrorBar;
        }else {
          resetPassword(context, controller);
        }
      },
    );
    AlertDialog alert = AlertDialog(
      title: const Text("Update", style: TextStyle(color: kPrimaryColor, fontSize: 20),),
      content: const Text("You may be forced to sign In again. Do you wish to continue?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    return (await showDialog(
      context: context,
      builder: (context) => alert,
    )) ?? false;
  }

  void resetPassword(BuildContext context, PasswordResetController controller)async{
    ProgressDialogHelper().loadingState;
    await controller.resetPassword();
    if(controller.viewState.state == ResponseState.COMPLETE){
      ProgressDialogHelper().loadStateTerminated;
      Get.offAllNamed(Routes.onBoarding);
      FlushBarHelper(context, Strings.updateSuccessMsg).showSuccessBar;
    }else if(controller.viewState.state == ResponseState.ERROR){
      ProgressDialogHelper().loadStateTerminated;
      FlushBarHelper(context, controller.errorMessage == Strings.emptyString ? Strings.internalServerError : Strings.errorOccurred).showErrorBar;
    }
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<PasswordResetController>(
      init: PasswordResetController(),
        builder: (controller){
      return Scaffold(
        key: controller.scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: Colors.white, elevation: 0, leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black,), onPressed: (){
          Get.back();
        },),),
        body: Form(
          key: controller.formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24,20,24,30),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Password", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),),
                const SizedBox(height: 36,),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Form(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Old Password", style: TextStyle(color: Colors.black, fontSize: 14),),
                              InkWell(
                                onTap: (){
                                  controller.togglePasswordVisibility();
                                },
                                child: Text(controller.togglePassword ? "Show" : "Hide", style: const TextStyle(color: kPrimaryColor, fontSize: 14),)),
                            ],
                          ),
                          const SizedBox(height: 12,),
                          FormFieldWidget(
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: controller.togglePassword,
                            controller: controller.oldPasswordController,
                          ),
                          const SizedBox(height: 24,),
                          const Text("New Password", style: TextStyle(color: Colors.black, fontSize: 14),),
                          const SizedBox(height: 12,),
                          FormFieldWidget(
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: controller.togglePassword,
                            validator: Validator.isStrongPassword,
                            controller: controller.newPasswordController,
                          ),
                          const SizedBox(height: 48,),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              fixedSize: const Size(double.maxFinite, 48),
                            ),
                            child: const Text("Update", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                            onPressed: (){
                              _onWillPop(controller);
                            },
                          ),
                        ],
                      ),),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

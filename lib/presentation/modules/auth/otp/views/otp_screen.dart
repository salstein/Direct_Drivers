import 'package:direct_drivers/app/constants/strings/strings.dart';
import 'package:direct_drivers/core/routes/app_route.dart';
import 'package:direct_drivers/presentation/modules/auth/otp/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../app/utils/flush_bar_loader.dart';
import '../../../../../app/utils/loading_dialog.dart';
import '../../../../../app/utils/validator.dart';
import '../../../../../app/widgets/custom_pin_code_field.dart';
import '../../../../../app/widgets/flexible_column.dart';
import '../../../../../core/state/view_state.dart';
import 'dart:developer';


class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {


  verifyOtp(OtpController controller) async {
    if(controller.formKey.currentState!.validate()){
      controller.formKey.currentState!.save();
      ProgressDialogHelper().dialogLoadingState(context,Strings.authentication);
      await controller.verifyOtp();
      if(controller.viewState.state == ResponseState.COMPLETE){
        ProgressDialogHelper().loadStateTerminated;
        Get.offAllNamed(Routes.driverVerification);
      }else if(controller.viewState.state == ResponseState.ERROR){
        ProgressDialogHelper().loadStateTerminated;
        FlushBarHelper(context, controller.errorMessage ?? Strings.errorOccurred).showErrorBar;
      }
    }
  }

  void verifyForgotPasswordOtp(OtpController controller)async{
    if(controller.formKey.currentState!.validate()){
      controller.formKey.currentState!.save();
      ProgressDialogHelper().loadingState;
      await controller.verifyResetPasswordOtp();
      if(controller.verifyForgotPasswordOtpViewState.state == ResponseState.COMPLETE){
        ProgressDialogHelper().loadStateTerminated;
        Get.offAllNamed(Routes.resetPassword);
      }else if(controller.verifyForgotPasswordOtpViewState.state == ResponseState.ERROR){
        ProgressDialogHelper().loadStateTerminated;
        FlushBarHelper(context, controller.errorMessage ?? Strings.errorOccurred).showErrorBar;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(top: false, bottom: false,
      child: GetBuilder<OtpController>(
        init: OtpController(),
          builder: (controller){
        return Scaffold(
          key: controller.scaffoldKey, backgroundColor: Colors.white,
          appBar: AppBar(backgroundColor: Colors.white, elevation: 0, leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black,), onPressed: (){
            Get.back();
          },),),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: controller.formKey,
              child: FlexibleScrollViewColumn(
                children: [
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Enter 4 digit verification code sent to your mobile phone", style: TextStyle(fontSize: 24),),
                      const SizedBox(height: 36,),
                      PinCodeField(
                        validator: Validator.isOtp,
                        onChanged: (String value){},
                        controller: controller.otpController,
                      ),
                      const SizedBox(height: 48,),
                      SizedBox(height: 48, width: double.maxFinite,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(elevation: 0),
                            child: const Text("Next", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                            onPressed: (){
                              controller.fromResetPassword == true ? verifyForgotPasswordOtp(controller) : verifyOtp(controller);
                              },
                          )
                      ),
                    ],
                  ),
                  ),
                ],
              ),
            ),
          ),
        );
      })
    );
  }

}

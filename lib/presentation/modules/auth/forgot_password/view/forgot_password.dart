import 'package:direct_drivers/app/constants/strings/strings.dart';
import 'package:direct_drivers/presentation/modules/auth/forgot_password/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../app/utils/flush_bar_loader.dart';
import '../../../../../app/utils/loading_dialog.dart';
import '../../../../../app/utils/validator.dart';
import '../../../../../app/widgets/custom_form_field.dart';
import '../../../../../app/widgets/flexible_column.dart';
import '../../../../../core/routes/app_route.dart';
import '../../../../../core/state/view_state.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  void verifyPhoneNumber(BuildContext context, ForgotPasswordController controller)async{
    if(controller.formKey.currentState!.validate()){
      controller.formKey.currentState!.save();
      ProgressDialogHelper().loadingState;
      await controller.forgotPassword();
      if(controller.viewState.state == ResponseState.COMPLETE){
        ProgressDialogHelper().loadStateTerminated;
        Get.offAllNamed(Routes.otp, arguments: Routes.forgotPassword);
      }else if(controller.viewState.state == ResponseState.ERROR){
        ProgressDialogHelper().loadStateTerminated;
        FlushBarHelper(context, controller.errorMessage ?? Strings.errorOccurred).showErrorBar;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(top: false, bottom: false,
      child: GetBuilder<ForgotPasswordController>(
        init: ForgotPasswordController(),
          builder: (controller){
        return Scaffold(
          key: controller.scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBar(backgroundColor: Colors.white, elevation: 0, leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black,), onPressed: (){
            Get.back();
          },),),
          body: FlexibleScrollViewColumn(
              padding: const EdgeInsets.fromLTRB(20,10,20,30),
              children: [
                Form(
                  key: controller.formKey,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Forgot Password?", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),),
                      const SizedBox(height: 24,),
                      const Text("Enter the phone number associated with this account",
                        style: TextStyle(color: Colors.black, fontSize: 14),),
                      const SizedBox(height: 24,),
                      const Text("Phone Number", style: TextStyle(color: Colors.black, fontSize: 14),),
                      const SizedBox(height: 12,),
                      FormFieldWidget(
                        controller: controller.phoneNumberController,
                        onChanged: (value){
                          controller.otpController.phoneNumber = controller.phoneNumberController.text;
                        },
                        validator: Validator.isPhone,
                      ),
                      const SizedBox(height: 48,),
                      SizedBox(height: 48, width: double.maxFinite,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(elevation: 0),
                            child: const Text("Next", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                            onPressed: (){
                              verifyPhoneNumber(context, controller);
                            },
                          )
                      ),
                    ],
                  ),
                ),
              ]
          ),
        );
      })
    );
  }
}


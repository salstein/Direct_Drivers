
import 'package:direct_drivers/app/widgets/custom_form_field.dart';
import 'package:direct_drivers/presentation/modules/auth/reset_password/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../app/utils/color_palette.dart';
import '../../../../../app/utils/flush_bar_loader.dart';
import '../../../../../app/utils/loading_dialog.dart';
import '../../../../../app/utils/validator.dart';
import '../../../../../core/routes/app_route.dart';
import '../../../../../core/state/view_state.dart';


class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  void resetPassword(BuildContext context, ResetPasswordController controller)async{
    if(controller.formKey.currentState!.validate()){
      controller.formKey.currentState!.save();
      ProgressDialogHelper().loadingState;
      await controller.resetPassword();
      if(controller.viewState.state == ResponseState.COMPLETE){
        ProgressDialogHelper().loadStateTerminated;
        Get.offAllNamed(Routes.login);
        FlushBarHelper(context,"Password Successful").showSuccessBar;
      }else if(controller.viewState.state == ResponseState.ERROR){
        ProgressDialogHelper().loadStateTerminated;
        FlushBarHelper(context, controller.errorMessage ?? "Error Occurred").showErrorBar;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResetPasswordController>(
      init: ResetPasswordController(),
        builder: (controller){
      return SafeArea(top: false, bottom: false,
        child: Scaffold(key: controller.scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBar(backgroundColor: Colors.white, elevation: 0, leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black,), onPressed: (){
            Get.back();
          },),),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20,10,20,30),
              child: Form(key: controller.formKey,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Create New Password", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),),
                    const SizedBox(height: 24,),
                    const Text("Your new password should be different from the previous ones.",
                      style: TextStyle(color: Colors.black, fontSize: 14),),
                    const SizedBox(height: 24,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("New Password", style: TextStyle(color: Colors.black, fontSize: 14),),
                        InkWell(
                          child: Text(controller.togglePassword ? "Show" : "Hide", style: const TextStyle(color: kPrimaryColor, fontSize: 14),),
                          onTap: (){
                            controller.togglePasswordVisibility();
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 12,),
                    FormFieldWidget(
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.visiblePassword,
                      suffixIcon: IconButton(icon: Icon(controller.togglePassword == true ? Icons.visibility_outlined : Icons.visibility_off_outlined, size: 20, color: Color(0xFFA0A4A8)),
                        onPressed: (){
                        controller.togglePasswordVisibility();
                        }),
                      controller: controller.newPasswordController,
                      validator: Validator.isStrongPassword,
                      obscureText: controller.togglePassword,
                    ),
                    const SizedBox(height: 48,),
                    SizedBox(height: 48, width: double.maxFinite,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(elevation: 0),
                          child: const Text("Reset Password", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                          onPressed: (){
                            resetPassword(context, controller);
                          },
                        )
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

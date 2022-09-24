import 'package:direct_drivers/app/constants/strings/strings.dart';
import 'package:direct_drivers/core/routes/app_route.dart';
import 'package:direct_drivers/presentation/modules/auth/sign_up/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../app/utils/color_palette.dart';
import '../../../../../app/utils/flush_bar_loader.dart';
import '../../../../../app/utils/loading_dialog.dart';
import '../../../../../app/utils/validator.dart';
import '../../../../../app/widgets/custom_form_field.dart';
import '../../../../../app/widgets/flexible_column.dart';
import '../../../../../core/state/view_state.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {


  void signUp(SignUpController controller)async{
    if(controller.formKeySignUp.currentState!.validate()){
      ProgressDialogHelper().loadingState;
      await controller.signUp();
      if(controller.viewState.state == ResponseState.COMPLETE){
        ProgressDialogHelper().loadStateTerminated;
        Get.offAllNamed(Routes.otp);
      }else if(controller.viewState.state == ResponseState.ERROR){
        ProgressDialogHelper().loadStateTerminated;
        FlushBarHelper(context, controller.errorMessage ?? Strings.errorOccurred).showErrorBar;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
      init: SignUpController(),
        builder: (controller){
      return SafeArea(top: false, bottom: false,
        child: Scaffold(key: controller.scaffoldKeySignUp,
          backgroundColor: Colors.white,
          appBar: AppBar(backgroundColor: Colors.white, elevation: 0, leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black,), onPressed: (){
            Get.back();
          },),),
          body: Form(
            key: controller.formKeySignUp,
            child: FlexibleScrollViewColumn(
              padding: const EdgeInsets.fromLTRB(20,10,20,30),
              children: [
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Sign Up", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),),
                      const SizedBox(height: 36,),
                      const Text("First Name", style: TextStyle(color: Colors.black, fontSize: 14),),
                      const SizedBox(height: 12,),
                      FormFieldWidget(
                        controller: controller.firstNameController,
                        validator: Validator.isName,
                        onChanged: (value){
                          controller.firstName = value;
                        },
                      ),
                      const SizedBox(height: 24,),
                      const Text("Last Name", style: TextStyle(color: Colors.black, fontSize: 14),),
                      const SizedBox(height: 12,),
                      FormFieldWidget(
                        controller: controller.lastNameController,
                        validator: Validator.isName,
                        onChanged: (value){
                          controller.lastName = value;
                        },
                      ),
                      const SizedBox(height: 24,),
                      const Text("Phone Number", style: TextStyle(color: Colors.black, fontSize: 14),),
                      const SizedBox(height: 12,),
                      FormFieldWidget(
                        controller: controller.phoneNumberController,
                        validator: Validator.isPhone,
                      ),
                      const SizedBox(height: 24,),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Password", style: TextStyle(color: Colors.black, fontSize: 14),),
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
                        controller: controller.passwordController,
                        validator: Validator.isStrongPassword,
                      ),
                      const SizedBox(height: 24,),
                      InkWell(
                        child: const Text("Forgot Password?", style: TextStyle(color: kPrimaryColor, fontSize: 14),),
                        onTap: (){
                          Get.toNamed(Routes.forgotPassword);
                        },
                      ),
                      const SizedBox(height: 36,),
                      Row(
                        children: [
                          InkWell(
                            onTap: ()=>controller.acceptTermAndConditions(),
                            child: Row(mainAxisSize: MainAxisSize.max,
                              children: [
                                controller.acceptTcs? Container(height: 18, width: 18,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: kPrimaryColor
                                  ),
                                  child: const Center(child: Icon(Icons.check, size: 15, color: Colors.white,)),
                                ) :
                                Container(height: 18, width: 18,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(width: 2, color: const Color(0xFFDADADA))
                                  ),
                                ),
                                const SizedBox(width: 15,),
                                const Text("I agree to the ", style: TextStyle(fontSize: 14))
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: ()=>Get.toNamed(Routes.termAndCondition),
                            child: const Text("Terms.", style: TextStyle(decoration: TextDecoration.underline,
                                color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 14),),)
                        ],
                      ),
                      const SizedBox(height: 5,),
                      !controller.acceptTcs ? Text('Please accept term and condition', style: TextStyle(color: Colors.red, fontSize: 12),) : const SizedBox(),
                      const SizedBox(height: 48,),
                      SizedBox(height: 48, width: double.maxFinite,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(elevation: 0),
                            child: const Text("Sign Up", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                            onPressed: (){
                              // log("This was click");
                              controller.acceptTcs == false ? null : signUp(controller);
                            }
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
    });
  }
}

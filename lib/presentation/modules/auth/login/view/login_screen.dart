import 'package:direct_drivers/app/constants/strings/strings.dart';
import 'package:direct_drivers/core/routes/app_route.dart';
import 'package:direct_drivers/core/state/view_state.dart';
import 'package:direct_drivers/presentation/modules/auth/login/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../app/utils/color_palette.dart';
import '../../../../../app/utils/flush_bar_loader.dart';
import '../../../../../app/utils/loading_dialog.dart';
import '../../../../../app/utils/validator.dart';
import '../../../../../app/widgets/custom_form_field.dart';
import '../../../../../app/widgets/flexible_column.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  void signUserIn(BuildContext context, LoginController controller)async{
    if(controller.formKey.currentState!.validate()){
      controller.formKey.currentState!.save();
      ProgressDialogHelper().loadingState;
      await controller.signAndSaveUserData();
      if(controller.viewState.state == ResponseState.COMPLETE){
        ProgressDialogHelper().loadStateTerminated;
        Get.offAllNamed(Routes.home);
      }else if(controller.viewState.state == ResponseState.ERROR){
        ProgressDialogHelper().loadStateTerminated;
        FlushBarHelper(context, controller.errorMessage == Strings.emptyString ? Strings.internalServerError : Strings.errorOccurred).showErrorBar;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
        builder: (controller){
      return SafeArea(top: false, bottom: false,
        child: Scaffold(backgroundColor: Colors.white, key: controller.scaffoldKey,
            appBar: AppBar(backgroundColor: Colors.white, elevation: 0, leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black,), onPressed: (){
              Get.back();
            },),),
            body: FlexibleScrollViewColumn(
              padding: const EdgeInsets.fromLTRB(20,10,20,30),
              children: [
                Expanded(
                  child: Form(key: controller.formKey,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Sign In", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),),
                        const SizedBox(height: 36,),
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
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.visiblePassword,
                          controller: controller.passwordController,
                          validator: Validator.isPassword,
                          obscureText: controller.togglePassword,
                          onChanged: (value){
                            controller.userPassword = value;
                          },
                        ),
                        const SizedBox(height: 12,),
                        InkWell(
                          child: const Text("Forgot Password?", style: TextStyle(color: kPrimaryColor, fontSize: 14),),
                          onTap: (){
                            Get.toNamed(Routes.forgotPassword);
                          },
                        ),
                        const SizedBox(height: 48,),
                        SizedBox(height: 48, width: double.maxFinite,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(elevation: 0),
                              child: const Text("Sign In", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                              onPressed: ()=> signUserIn(context,controller),
                            )
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
        ),
      );
    });
  }
}

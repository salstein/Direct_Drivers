import 'package:direct_drivers/app/constants/strings/strings.dart';
import 'package:direct_drivers/core/routes/app_route.dart';
import 'package:direct_drivers/presentation/modules/auth/verifcation/controller/verification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../app/utils/flush_bar_loader.dart';
import '../../../../../app/utils/loading_dialog.dart';
import '../../../../../app/utils/validator.dart';
import '../../../../../app/widgets/custom_drop_down_menu.dart';
import '../../../../../app/widgets/custom_form_field.dart';
import '../../../../../app/widgets/flexible_column.dart';
import '../../../../../core/state/view_state.dart';


class DriverVerification extends StatefulWidget {
  const DriverVerification({Key? key}) : super(key: key);

  @override
  _DriverVerificationState createState() => _DriverVerificationState();
}

class _DriverVerificationState extends State<DriverVerification> {


  void validateParamAndVerifyStaff(VerificationController controller){
    if (controller.selectedCountry == null){
      FlushBarHelper(context,"Please select country").showErrorBar;
    }else if(controller.selectedState == null){
      FlushBarHelper(context,"Please select state").showErrorBar;
    }else if(controller.selectedLga == null){
      FlushBarHelper(context,"Please select LGA").showErrorBar;
    } else{
      return verifyStaff(controller);
    }
  }

  void verifyStaff(VerificationController controller)async{
    if(controller.formKeyStaffVerification.currentState!.validate()){
      controller.formKeyStaffVerification.currentState!.save();
      ProgressDialogHelper().loadingState;
      await controller.staffVerification();
      if(controller.viewState.state == ResponseState.COMPLETE){
        ProgressDialogHelper().loadStateTerminated;
        controller.fromProfileUpdate == true ? Get.offAllNamed(Routes.home) : Get.offAllNamed(Routes.login);
        FlushBarHelper(context, Strings.regCompleted).showSuccessBar;
      }else if(controller.viewState.state == ResponseState.ERROR){
        ProgressDialogHelper().loadStateTerminated;
        FlushBarHelper(context, controller.errorMessage ?? Strings.errorOccurred).showErrorBar;
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerificationController>(
      init: VerificationController(),
        builder: (controller){
      return SafeArea(top: false, bottom: false,
        child: Scaffold(
          key: controller.scaffoldKeyStaffVerification,
          backgroundColor: Colors.white,
          appBar: AppBar(backgroundColor: Colors.white, elevation: 0, leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black,), onPressed: (){
            Get.back();
          },),),
          body: Form(
            key: controller.formKeyStaffVerification,
            child: FlexibleScrollViewColumn(
              padding: const EdgeInsets.fromLTRB(20,10,20,30),
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Verification", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                    const SizedBox(height: 36,),
                    const Text("Address", style: TextStyle(color: Colors.black, fontSize: 14),),
                    const SizedBox(height: 12,),
                    FormFieldWidget(
                      validator: Validator.isAddress,
                      controller: controller.addressController,
                    ),
                    const SizedBox(height: 24,),
                    const Text("Country", style: TextStyle(color: Colors.black, fontSize: 14),),
                    const SizedBox(height: 12,),
                    DropDownMenuWidget(
                      value: controller.selectedCountry,
                      onChanged: (String? value){
                        controller.selectCountry(value);
                      },
                      items: controller.countries.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 17),),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24,),
                    const Text("State", style: TextStyle(color: Colors.black, fontSize: 14),),
                    const SizedBox(height: 12,),
                    DropDownMenuWidget(
                      value: controller.selectedState,
                      onChanged: (String? value){
                        controller.selectState(value!);
                      },
                      items: controller.states!.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(value: value,
                          child: Text(value, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 17),),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24,),
                    const Text("First Name", style: TextStyle(color: Colors.black, fontSize: 14),),
                    const SizedBox(height: 12,),
                    controller.fromProfileUpdate == true ?
                    FormFieldWidget(
                      validator: Validator.isName,
                      controller: controller.firstNameController,
                    ) :
                    FormFieldWidget(
                      validator: Validator.isName,
                      controller: controller.firstNameController,
                    ),
                    const SizedBox(height: 24,),
                    const Text("Last Name", style: TextStyle(color: Colors.black, fontSize: 14),),
                    const SizedBox(height: 12,),
                    controller.fromProfileUpdate == true ?
                    FormFieldWidget(
                      validator: Validator.isName,
                      controller: controller.lastNameController,
                    ) :
                    FormFieldWidget(
                      validator: Validator.isName,
                      controller: controller.lastNameController,
                    ),
                    const SizedBox(height: 24,),
                    const Text("LGA", style: TextStyle(color: Colors.black, fontSize: 14),),
                    const SizedBox(height: 12,),
                    DropDownMenuWidget(
                      value: controller.selectedLga,
                      onChanged: (String? value){
                        controller.selectLga(value);
                      },
                      items: controller.lga.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 17),),
                        );
                      }).toList(),
                    ),
                    // const SizedBox(height: 24,),
                    // const Text("Phone Number", style: TextStyle(color: Colors.black, fontSize: 14),),
                    // const SizedBox(height: 12,),
                    // FormFieldWidget(
                    //   controller: controller.phoneNumberController,
                    //   validator: Validator.isPhone,
                    // ),
                    const SizedBox(height: 48,),
                    SizedBox(height: 48, width: double.maxFinite,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(elevation: 0),
                          child: const Text("Next", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                          onPressed: (){
                            validateParamAndVerifyStaff(controller);
                          }
                        )
                    ),
                    const SizedBox(height: 50,),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../utils/color_palette.dart';


class PinCodeField extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String) onChanged;
  final String? Function(String?)? validator;
  const PinCodeField({Key? key, this.controller, required this.onChanged, this.validator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
        child: PinCodeTextField(
          appContext: context, pastedTextStyle: const TextStyle(color: Colors.black,),
          length: 4, errorTextSpace: 20,
          enablePinAutofill: false, obscureText: true, autoDisposeControllers: false,
          blinkWhenObscuring: true, autovalidateMode: AutovalidateMode.disabled,
          animationType: AnimationType.fade,
          validator: validator,
          pinTheme: PinTheme(
            borderWidth: 1, shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50, fieldWidth: 50,
            errorBorderColor: kGrayScale1, selectedColor: kGrayScale1,
            selectedFillColor: kGrayScale1, activeColor: kGrayScale1,
            activeFillColor: kGrayScale1, inactiveColor: kGrayScale1,
            inactiveFillColor: kGrayScale1,
          ),
          cursorColor: Colors.black,
          animationDuration: const Duration(milliseconds: 300),
          enableActiveFill: true,
          controller: controller,
          keyboardType: TextInputType.number,
          onChanged: onChanged,
        ));
  }
}

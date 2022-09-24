import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/color_palette.dart';

class FormFieldWidget extends StatelessWidget {
  final String? labelText;
  final TextStyle? labelStyle;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final Widget? icon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final TextStyle? style;
  final bool? obscureText;
  final Widget? prefixIcon;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final TextCapitalization? textCapitalization;
  final bool? readOnly;
  final String? initialValue;
  const FormFieldWidget({Key? key, this.labelText, this.labelStyle, this.keyboardType, this.textInputAction, this.inputFormatters, this.onSaved, this.controller, this.onChanged, this.icon, this.validator, this.onTap, this.suffixIcon, this.style, this.obscureText, this.prefixIcon, this.hintText, this.hintTextStyle, this.textCapitalization, this.readOnly, this.initialValue, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      obscureText: obscureText ?? false, readOnly: readOnly ?? false,
      style: style ?? Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 18),
      textCapitalization: textCapitalization ?? TextCapitalization.words,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onSaved: onSaved, controller: controller, onChanged: onChanged,
      inputFormatters: inputFormatters, cursorHeight: 25,
      onTap: onTap,
      textInputAction: textInputAction ?? TextInputAction.next, keyboardType: keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        suffixIcon: suffixIcon, prefixIcon: prefixIcon,
        icon: icon,
        labelText: labelText,
        hintText: hintText,
        hintStyle: hintTextStyle ?? Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0xff868484), fontSize: 16),
        labelStyle: labelStyle ?? Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0xff868484), fontSize: 16),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: kGrayScale1, width: 0.7)
        ),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: kGrayScale1, width: 0.7)
        ),
        focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: kGrayScale1, width: 0.7)
        ),
        errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: kGrayScale1, width: 0.7)
        ),
        fillColor: kGrayScale1,
        filled: true, isDense: true,
        contentPadding: const EdgeInsets.all(15),
      ),
      cursorColor: kPrimaryColor,
      validator: validator,
    );
  }
}

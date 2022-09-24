import 'package:get/get.dart';

class Validator{
  static String? isPhone(String? value) {
    if (value?.isEmpty ?? true) {
      return 'This field is required';
    } else if (!GetUtils.isNumericOnly(value!.trim()) ||
        !GetUtils.isLengthEqualTo(value.trim(), 11)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  static String? isAddress(String? value) {
    if (value?.isEmpty ?? true) {
      return 'This field is required';
    } else if (!GetUtils.isLengthGreaterThan(value, 4)) {
      return 'Please enter a valid Address';
    }
    return null;
  }

  static String? isFullName(String? value) {
    String pattern = r"^([a-zA-Z]{2,}\s[a-zA-z]{1,}'?-?[a-zA-Z]{2,}\s?([a-zA-Z]{1,})?)";
    RegExp regExp = RegExp(pattern);
    if (value?.isEmpty ?? true) {
      return 'This field is required';
    } else if (!regExp.hasMatch(value!)) {
      return 'Please enter valid Full name';
    }
    return null;
  }

  static String? isName(String? value) {
    String pattern = r"([a-zA-Z]{3,30}\s*)+";
    RegExp regExp = RegExp(pattern);
    if (value?.isEmpty ?? true) {
      return 'This field is required';
    } else if (!regExp.hasMatch(value!)) {
      return 'Please enter valid Full name';
    }
    return null;
  }

  static String? isStrongPassword(String? value) {
    if (value!.isEmpty) {
      return 'Please enter password';
    }else if (value.length < 8) {
      return 'Password must be up to 8 characters';
    } else if (!value.contains(RegExp(r"[A-Z]"))){
      return 'Password must contain at least one uppercase';
    } else if (!value.contains(RegExp(r"[a-z]"))){
      return 'Password must contain at least one lowercase';
    }else if (!value.contains(RegExp(r"[0-9]"))){
      return 'Password must contain at least one number';
    }
    return null;
  }

  static String? isPassword(String? value) {
    if (value?.isEmpty ?? true) {
      return 'This field is required';
    } else if (!GetUtils.isLengthGreaterOrEqual(value, 8)) {
      return 'Password must be 8 characters long';
    }
    return null;
  }

  static String? isOtp (String? value) {
    if(value!.isEmpty){
      return "Please enter 4-digit pin";
    } else if (value.length < 4) {
      return "Pin must be 4 digits";
    } else {
      return null;
    }
  }
}
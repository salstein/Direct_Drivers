import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/color_palette.dart';

class MySimpleDialog{
  MySimpleDialog({this.context, this.titleText, this.contentText, this.onYesPressed});
  BuildContext? context;
  String? titleText;
  String? contentText;

  void Function()? onYesPressed;
  Future<bool> onWillPop() async {
    Widget cancelButton = TextButton(
      child: const Text("NO", style: TextStyle(color: kPrimaryColor),),
      onPressed: ()=> SystemNavigator.pop(),
    );

    Widget continueButton = TextButton(
      child: const Text("YES", style: TextStyle(color: kPrimaryColor),),
      onPressed: onYesPressed!,
    );

    AlertDialog alert = AlertDialog(
      title: Text(titleText!, style: TextStyle(color: kPrimaryColor, fontSize: 20),),
      content: Text(contentText!),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    return (await showDialog(
      context: context!,
      builder: (context) => alert,
    )) ?? false;
  }
}
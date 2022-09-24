import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlushBarHelper{
  BuildContext? c;
  Flushbar? flush;
  String? message;
  FlushBarHelper(this.c, this.message);

  showFlushBar({Color? color}){
    flush = Flushbar(
      message:  message, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: color ?? Colors.blueGrey,
      margin: EdgeInsets.all(15),
      borderRadius: BorderRadius.circular(5),
      isDismissible: true,
      duration: const Duration(seconds: 3),
    )..show(c ?? Get.context!);
  }

  get showErrorBar => FlushBarHelper(Get.context!, message).showFlushBar(color: Colors.red);
  get showSuccessBar => FlushBarHelper(Get.context!, message).showFlushBar(color: Colors.green);

  showFlushBarWithAction(String message, String action, {Color? color, Function? actionFunction}){
    flush = Flushbar(
      message:  message, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: color ?? Colors.blueGrey,
      margin: const EdgeInsets.all(15),
      borderRadius: BorderRadius.circular(5),
      isDismissible: true,
      duration: const Duration(seconds: 10),
      mainButton: TextButton(
        onPressed: () {
          actionFunction?.call();
          flush?.dismiss(true);
        },
        child: Text(action, style: const TextStyle(color: Colors.amber),
        ),
      ),
    )..show(c ?? Get.context!);
  }
}
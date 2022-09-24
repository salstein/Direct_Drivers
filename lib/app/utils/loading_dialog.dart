import 'package:get/get.dart';
import 'package:ndialog/ndialog.dart';
import 'package:flutter/cupertino.dart';

class ProgressDialogHelper{
  late NAlertDialog dialog;

  dialogLoadingState(BuildContext context, String message){
    dialog = NAlertDialog(
      dialogStyle: DialogStyle(titleDivider: true),
      title: const Text("Please wait"),
      content: Row(
        children: [
          const CupertinoActivityIndicator(radius: 20,),
          const SizedBox(width: 10,),
          Text(message),
        ],
      ),
      blur: 2, dismissable: false,
    );
    dialog.show(context, transitionType: DialogTransitionType.Shrink);
  }
  hideProgressDialog(BuildContext context){
    Navigator.pop(context);
  }

  get loadStateTerminated => Get.back();
  get loadingState => ProgressDialogHelper().dialogLoadingState(Get.context!, "Processing...");
}
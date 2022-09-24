import 'package:direct_drivers/app/constants/strings/strings.dart';
import 'package:direct_drivers/presentation/modules/drivers/notification/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReadNotification extends StatelessWidget {
  const ReadNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
      init: NotificationController(),
        builder: (controller){
     return SafeArea(top: false, bottom: false,
         child: Scaffold(
           appBar: AppBar(
             elevation: 0.0, backgroundColor: Colors.white,
             leading: IconButton(onPressed: (){
               Get.back();
             }, icon: Icon(Icons.arrow_back, color: Colors.black, size: 20,)),
           ),
           body: Padding(
             padding: const EdgeInsets.symmetric(horizontal: 24.0),
             child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 const SizedBox(height: 14,),
                 const Text(Strings.readNotification, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                 const SizedBox(height: 14,),
                 Expanded(
                     child: Text(controller.notification[controller.selectedIndex!].body!, style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 15),)
                 ),
               ],
             ),
           ),
         )
     );
    });
  }
}

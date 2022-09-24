import 'package:direct_drivers/core/routes/app_route.dart';
import 'package:direct_drivers/presentation/modules/drivers/notification/controller/controller.dart';
import 'package:direct_drivers/presentation/modules/drivers/notification_details/views/read_notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../app/constants/strings/strings.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../../app/utils/color_palette.dart';
import '../../../../../app/utils/dummy_data.dart';
import '../../../../../app/widgets/empty_screen.dart';
import '../../../../../app/widgets/error_screen.dart';
import '../../../../../app/widgets/loading_widget.dart';
import '../../../../../core/state/view_state.dart';



class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  Widget buildNotificationScreen(NotificationController controller){
    switch (controller.viewState.state){
      case ResponseState.LOADING:
        return LoadingWidget(loadingMessage: Strings.loadingTrip,);
      case ResponseState.COMPLETE:
        final items = controller.viewState.data;
        return Padding(
          padding: const EdgeInsets.fromLTRB(24,20,24,30),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(Strings.notification, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
              const SizedBox(height: 14,),
              Expanded(child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("You have one unread message.", style: TextStyle(fontSize: 15,),),
                      const SizedBox(height: 22,),
                      Column(
                        children: List.generate(items!.length, (index){
                          final secondsAgo = items[index].createdAt?.subtract(Duration(seconds: 10));
                          return InkWell(
                            onTap: (){
                              controller.navigateToNextPage(index: index);
                              controller.getSelectedItem();
                              Get.toNamed(Routes.readNotification);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 40),
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(24,26,24,14),
                                decoration: BoxDecoration(color: const Color(0xFFF8F8F8), borderRadius: BorderRadius.circular(4),),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(padding: const EdgeInsets.only(top: 2.5),
                                          child: Container(height: 10, width: 10,
                                            decoration: const BoxDecoration(color: kPrimaryColor, shape: BoxShape.circle,),
                                          ),
                                        ),
                                        const SizedBox(width: 14,),
                                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("${items[index].title}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),),
                                            const SizedBox(height: 15,),
                                            Text("${items[index].body}", style: TextStyle(fontSize: 14, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),),
                                      ],
                                    ),
                                    const SizedBox(height: 12,),
                                    Text(timeago.format(secondsAgo!), style: const TextStyle(fontSize: 14, color: Color(0xFFA0A4A8)),),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                )
              )
            ],
          ),
        );
      case ResponseState.ERROR:
        return const ErrorScreen();
      case ResponseState.EMPTY:
        return const EmptyScreen();
    }
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
      init: NotificationController(),
        builder: (controller){
      return Scaffold(
        body: buildNotificationScreen(controller),
      );
    });
  }
}


String convertToAgo(DateTime input){
  Duration diff = DateTime.now().difference(input);

  if(diff.inDays >= 1){
    return '${diff.inDays} day(s) ago';
  } else if(diff.inHours >= 1){
    return '${diff.inHours} hour(s) ago';
  } else if(diff.inMinutes >= 1){
    return '${diff.inMinutes} minute(s) ago';
  } else if (diff.inSeconds >= 1){
    return '${diff.inSeconds} second(s) ago';
  } else {
    return 'just now';
  }
}

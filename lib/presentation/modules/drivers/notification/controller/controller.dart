import 'package:direct_drivers/data/remote/repositories/driver_repository/notification_repository.dart';
import 'package:direct_drivers/data/remote/services/driver_services/notification_service.dart';
import 'package:direct_drivers/domain/drivers_repository/notification_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../core/state/view_state.dart';
import '../../../../../data/models/notification_model.dart';
import '../../../../../data/remote/dio/dio_data_state.dart';
import 'dart:developer';

class NotificationController extends GetxController{
  final _getNotification = Get.put(GetNotificationAlert(NotificationRepository(NotificationServices())));
  String? errorMessage;
  List<Notification> notification = <Notification>[].obs;

  ViewState<List<Notification>?> viewState = ViewState(state: ResponseState.EMPTY);

  void _setViewState(ViewState<List<Notification>?> viewState) {
    this.viewState = viewState;
  }

  int? selectedIndex;

  navigateToNextPage({required int index}) {
    selectedIndex = index;
  }

  getSelectedItem() {
    return notification.elementAt(selectedIndex!);
  }


  Future<void> getNotification()async{
    _setViewState(ViewState.loading());
    await _getNotification.noParamCall().then((value) async {
      if(value is DataSuccess || value.data != null) {
        notification = value.data!;
        _setViewState(ViewState.complete(value.data!));
        update();
      }if (value is DataFailed || value.data == null) {
        if (kDebugMode) {
          log(value.error.toString());
          print(value.error);
        }errorMessage = value.error.toString();
        update();
        _setViewState(ViewState.error(value.error.toString()));
      }}
    );
  }

  @override
  void onInit() {
    getNotification();
    super.onInit();
  }
}
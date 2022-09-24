import 'package:dio/dio.dart';
import 'package:direct_drivers/data/remote/services/driver_services/notification_service.dart';

class NotificationRepository{
  final NotificationServices _notificationServices;
  NotificationRepository(this._notificationServices);
  Future<Response> getNotification() => _notificationServices.getNotification();
}
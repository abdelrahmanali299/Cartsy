import 'package:fake_store/features/home/presentation/notification_view.dart';
import 'package:fake_store/features/order/data/models/notification_model.dart';
import 'package:fake_store/main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static void onTap(NotificationResponse notificationResponse) {
    final payload = notificationResponse.payload;
    if (payload != null) {
      navigatorKey.currentState!.pushNamed(NotificationView.routeName);
    }
  }

  static Future init() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onTap,

      onDidReceiveBackgroundNotificationResponse: onTap,
    );
  }

  static Future showBasicNotification({
    required NotificationModel notificationModel,
  }) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'your channel id',
          'your channel name',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
        );
    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      notificationModel.id ?? 0,
      notificationModel.title,
      notificationModel.body,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }
}

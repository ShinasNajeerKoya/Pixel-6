import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationService {
  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
      'resource://drawable/res_codeland_vector',
      [
        NotificationChannel(
          channelKey: "codeland_channel",
          channelName: "Codeland Notification",
          channelDescription: "Notification channel for codeland application",
          // importance: NotificationImportance.High,
          // enableLights: true,
          // enableVibration: true,
          playSound: false,
        )
      ],
      debug: true,
    );

    await AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) async {
        if (!isAllowed) {
          await AwesomeNotifications().requestPermissionToSendNotifications();
        }
      },
    );
  }
}

// lib/notification_util.dart

import 'package:awesome_notifications/awesome_notifications.dart';

void sendNotification({required int id, required String title, required String body}) {
  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: id,
      channelKey: "codeland_channel",
      title: title,
      body: body,
    ),
  );
}

void sendWelcomeNotification() {
  sendNotification(
    id: 01,
    title: "Welcome to Codeland",
    body: "We heartily welcome you to our application, Codeland. 😊",
  );
}

void sendTestNotification() {
  sendNotification(
    id: 02,
    title: "Test notification for Codeland",
    body: "Test test",
  );
}

void profilePictureUpdatedNotification() {
  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 03,
      channelKey: "codeland_channel",
      title: "Profile Picture Updated!",
      body: "Your profile picture has been updated successfully!",
    ),
  );
}

void sendLogoutNotification() {
  sendNotification(
    id: 04,
    title: "Are you leaving already? 😢",
    body: "You're welcome back anytime! 😊",
  );
}

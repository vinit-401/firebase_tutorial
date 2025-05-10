import 'package:firebase_messaging/firebase_messaging.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;

Future<void> getToken() async {
  String? token = await messaging.getToken();
  print("FCM Token: $token");
  // Send this token to your server

}


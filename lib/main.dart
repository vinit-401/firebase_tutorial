import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:untitled/firebase_options.dart';
import 'package:untitled/services/messaging.dart';
import 'package:untitled/services/notification_service.dart';
import 'package:untitled/ui/home_screen.dart';
import 'package:untitled/ui/register/signup_screen.dart';

// 🔔 Local notifications plugin instance
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService.instance.initialize();
  runApp(const MyApp());
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   // ✅ Firebase Initialization
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//
//   // ✅ Local Notification Setup
//
//   // ✅ Firebase Cloud Messaging Token (print for testing)
//   await getToken();
//
//   // ✅ FCM Listeners
//   FirebaseMessaging.onMessage.listen(handleForegroundMessage);
//   FirebaseMessaging.onMessageOpenedApp.listen(handleNotificationOpened);
//
//   runApp(const MyApp());
// }

// 🛠️ Setup local notifications
Future<void> setupFlutterNotifications() async {
  const AndroidInitializationSettings androidInit =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initSettings =
  InitializationSettings(android: androidInit);

  await flutterLocalNotificationsPlugin.initialize(initSettings);
}

// 🔔 Handle foreground notifications
void handleForegroundMessage(RemoteMessage message) {
  print('📥 Foreground message: ${message.notification?.title}');

  // final notification = message.notification;
  // final android = message.notification?.android;
  //
  // if (notification != null && android != null) {
  //   flutterLocalNotificationsPlugin.show(
  //     notification.hashCode,
  //     notification.title,
  //     notification.body,
  //     const NotificationDetails(
  //       android: AndroidNotificationDetails(
  //         'high_importance_channel', // Channel ID
  //         'High Importance Notifications', // Channel name
  //         importance: Importance.high,
  //         priority: Priority.high,
  //       ),
  //     ),
  //   );
  // }
}

// 📲 Handle notification tap when app opened from background
void handleNotificationOpened(RemoteMessage message) {
  print('📲 Notification tapped: ${message.notification?.title}');
}

// 🏠 Main App Widget
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return snapshot.hasData ? const HomeScreen() : const SignUpScreen();
        },
      ),
    );
  }
}

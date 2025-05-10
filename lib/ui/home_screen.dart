import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:untitled/controllers/controller.dart';
import 'package:untitled/ui/add_screen.dart';
import 'package:untitled/ui/edit_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final FirebaseMessaging _messaging;
  @override
  void initState() {
    super.initState();
    _initFCM();
  }

  void _initFCM() async {
    _messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await _messaging.requestPermission();
    print('🔐 Permission granted: ${settings.authorizationStatus}');

    // 🔹 Get device token
    String? token = await _messaging.getToken();
    print("📲 FCM Token: $token");

    // 🔹 Foreground message handler
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('📥 Foreground message: ${message.notification?.title}');
      // You can show a local notification here using flutter_local_notifications
    });


    // 🔹 When app is opened from background by tapping on notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('📲 App opened from notification: ${message.notification?.title}');
      // Navigate or handle logic based on notification
    });

    // 🔹 Check for initial message when app is launched via notification
    RemoteMessage? initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      print('🚀 App launched via notification: ${initialMessage.notification?.title}');
    }
  }

  @override
  Widget build(BuildContext context) {
    FirebaseController.getDataFromDatabase();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        title: Text('Data'),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseController.userLogOut();
              },
              icon: Icon(Icons.login_outlined))
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.white,
                  Colors.white70,
                  Colors.white,
                  Colors.greenAccent.shade100,
                ],
              ),
            ),
          ),
          StreamBuilder(
            stream: FirebaseController.getDataFromDatabase(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Icon(
                    Icons.home,
                    size: 68,
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(
                  color: Colors.teal,
                );
              }
              return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.startToEnd,
                    onDismissed: (direction) {
                      if (direction == DismissDirection.startToEnd) {
                        FirebaseController.deleteData(snapshot.data!.docs[index].id);
                      }
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.teal.shade100,
                        child: Text('${index + 1}'),
                      ),
                      title: Text(
                        snapshot.data!.docs[index].get('name'),
                      ),
                      subtitle: Text(snapshot.data!.docs[index].get('pin').toString()),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return EditScreen(
                              docs: snapshot.data!.docs[index],
                            );
                          },
                        ));
                      },
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddScreen(),
              ));
        },
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: Colors.green,
        ),
      ),
    );
  }
}

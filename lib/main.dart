import 'package:coding_task/screens/dashboard.dart';
import 'package:coding_task/screens/login.dart';
import 'package:coding_task/screens/notification_demo.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

void main() {
  FirebaseMessaging messaging = new FirebaseMessaging();

  messaging.configure(onMessage: (Map<String, dynamic> data) async {
    print("Message: $data");
  });

  messaging.onTokenRefresh.listen((data) => sendTokenToServer(data));

  runApp(MaterialApp(
    routes: {
      '/': (context) => LoginScreen(),
      '/dashboard': (context) => Dashboard(),
      '/notification': (context) => NotificationDemo()
    },
    initialRoute: "/",
  ));
}

sendTokenToServer(token) {
  // server side token sent
  print(token);
}

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification Demo"),
      ),
      body: Center(
        child: Container(
          child: FutureBuilder(
            future: FirebaseMessaging().getToken(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return SelectableText("Registration ID:\n"+snapshot.data);
              } else
                return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

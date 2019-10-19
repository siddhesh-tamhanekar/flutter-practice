import 'package:coding_task/screens/dashboard.dart';
import 'package:coding_task/screens/login.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  routes: {
    '/':(context) => LoginScreen(),
    '/dashboard': (context) => Dashboard()
  },
      initialRoute: "/",
    ));



import 'dart:async';

import 'package:coding_task/bloc/auth_bloc.dart';
import 'package:coding_task/models.dart';
import 'package:coding_task/screens/login.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  routes: {
    '/':(context) => LoginScreen(),
    '/dashboard': (context) => Dashboard()
  },
      initialRoute: "/",
    ));


class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final authbloc = AuthBloc();
  StreamSubscription subscription;
  @override
  void initState() {
    subscription = authbloc.response.listen((data) {
      if(data is LogoutResponse)
        Navigator.pushReplacementNamed(context, "/");
    });
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    authbloc.destroy();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    LoginSuccessResponse resp = ModalRoute.of(context).settings.arguments;
    String message = "You are Logged in using "+(resp.via=="fb"?"Facebook":"TouchID");
    const textStyle =TextStyle(color: Colors.white,fontSize: 14.0);

    return Scaffold(
      body: SafeArea(
              child: Column(

          children: <Widget>[
            Container(
              color: Colors.blue,
              padding: EdgeInsets.symmetric(horizontal: 4.0,vertical:8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(message,style: textStyle,),
                  RaisedButton(child: Text("Logout"),onPressed: (){
                    authbloc.action.add(LogoutEvent(resp.via));
                  },)

                ],
              ),
            ),
            Center(child: Text("hello world"),),
          ],
        ),
      ),
      
    );
  }
}
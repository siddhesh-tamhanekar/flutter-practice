import 'dart:async';

import 'package:coding_task/bloc/auth_bloc.dart';
import 'package:coding_task/models.dart';
import 'package:flutter/material.dart';

import '../models.dart' show LoginEvent;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  AuthBloc authbloc = AuthBloc();
  StreamSubscription subscription;
  @override
  void initState() {
    super.initState();
    subscription = authbloc.response.listen(( data){
        if(data is LoginSuccessResponse)
          Navigator.pushNamed(context, "/dashboard",arguments: data);
        if( data is CancelledByUserResponse)
          _key.currentState.showSnackBar(SnackBar(content: Text("Login Cancelled by User"),));
   })..onError((error) { print("in error");print(error);});
  }

  @override
  void dispose() {
    subscription.cancel();
    authbloc.destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: Center(

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            
            _buildLoginButton(Icons.face,"Login Using Facebook","fb"),
            SizedBox(height: 10.0),
            _buildLoginButton(Icons.fingerprint,"Login Using FingerPrint","touchid"),
          ],
        )      ),
    );
  }

  RaisedButton _buildLoginButton(IconData icon, String label, String key) {
    return RaisedButton(
            textColor: Colors.white,
            color: Colors.blue,
            onPressed:(){
              authbloc.action.add(LoginEvent(key));
            },
            child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon),
              SizedBox(width: 10.0,),
              Text(label),
            ],
          ),);
  }
}

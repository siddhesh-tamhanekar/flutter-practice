import 'dart:async';

import 'package:rxdart/subjects.dart';
import '../models.dart';
import '../services/auth_service.dart';


class AuthBloc {
  
  PublishSubject<Event> action;
  Stream<Response> response;

  AuthBloc() {
    action = new PublishSubject<Event>();

    response = action.asyncMap((Event actionEvent) {

      if(actionEvent is LoginEvent && actionEvent.type=='fb' ) 
        return AuthService.fbLogin();
      else if(actionEvent is LoginEvent && actionEvent.type=='touchid')
        return AuthService.touchIDLogin();
      else if(actionEvent is LogoutEvent )
        return AuthService.fbLogout(); 
      
    });
  }

  void destroy() {
    action.close();
  }
  


}
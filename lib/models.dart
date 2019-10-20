import 'package:google_maps_flutter/google_maps_flutter.dart';

class Event{}
class LoginEvent extends Event{
  String type;

  LoginEvent(this.type);
}

class LogoutEvent extends Event{
  String type;

  LogoutEvent(this.type);
}

class CurrentLocationEvent extends Event {}
class PlotRouteEvent extends Event {
  LatLng current;
  PlotRouteEvent(this.current);  
}


class Response{}

class LoginSuccessResponse extends Response{
 String  token;
 String via;
 LoginSuccessResponse(this.token,this.via);
 
}


class LogoutResponse extends Response{}

class CancelledByUserResponse  extends Response{}

class ErrorResponse  extends Response{
  String error;
  ErrorResponse(error);
}

class CurrentLocationResponse extends Response{
  LatLng loc;
  CurrentLocationResponse(this.loc);
}

class RouteResponse extends Response {
  Polyline line;
  LatLngBounds box;
  LatLng current;
  RouteResponse(this.line, this.box,this.current );
}
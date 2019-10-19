class Event{}
class LoginEvent extends Event{
  String type;

  LoginEvent(this.type);
}

class LogoutEvent extends Event{
  String type;

  LogoutEvent(this.type);
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
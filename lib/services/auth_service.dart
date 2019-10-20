import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:local_auth/local_auth.dart';

import '../models.dart';

class AuthService {
  static final facebookLogin = FacebookLogin();
  static final auth = LocalAuthentication();

  static Future<Response> fbLogin() async {
    // facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
    final result = await facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        return LoginSuccessResponse(result.accessToken.token,"fb");
        break;
      case FacebookLoginStatus.cancelledByUser:
        return CancelledByUserResponse();
        break;
      case FacebookLoginStatus.error:
        throw ErrorResponse(result.errorMessage);
        break;
    }
    return ErrorResponse(result.errorMessage);
  }

  static isTouchIdAvailable() async {
    return auth.canCheckBiometrics;
  }

  static Future<Response> touchIDLogin() async {
    var auth = LocalAuthentication();
    final result = await auth.authenticateWithBiometrics(
      localizedReason: "Please authenticate to continue",
    );
    print(result);
    if (result == true)
      return LoginSuccessResponse("", "touchId");
    else
      return CancelledByUserResponse();
  }

  static Future<Response> fbLogout() async {
    await facebookLogin.logOut();
    return LogoutResponse();
  }
 }

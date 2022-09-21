import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../domain/entities/auth_token.dart';
import 'login_presenter.dart';

class LoginController extends Controller {
  LoginPresenter? loginPresenter;
  AuthToken? _authToken;
  AuthToken? get getAuthToken => _authToken;

  LoginController(loginDetailsRepository)
      : loginPresenter = LoginPresenter(loginDetailsRepository),
        super();

  @override
  void initListeners() {
    loginPresenter!.getAuthTokenOnNext = (AuthToken loginDetails) {
      print("auth on next");
      _authToken = loginDetails;
      refreshUI();
    };
    loginPresenter!.getAuthTokenOnComplete = () {
      print("auth on complete");
    };

    loginPresenter!.getAuthTokenOnError = (e) {
      print(e);
    };
    refreshUI();
  }

  login({required String? email, required String? pass}) async {
    loginPresenter!.login(email: email, password: pass);
  }
}

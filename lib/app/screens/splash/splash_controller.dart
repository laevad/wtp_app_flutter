import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'splash_presenter.dart';

class SplashController extends Controller {
  final SplashPresenter? splashPresenter;
  bool? _isAuth;
  bool? get isAuth => _isAuth;

  SplashController(authRepository)
      : splashPresenter = SplashPresenter(authRepository),
        super();

  @override
  void onDisposed() {
    splashPresenter?.dispose();
    super.onDisposed();
  }

  @override
  void initListeners() {
    splashPresenter!.isAuth();

    splashPresenter!.isAuthOnNext = (bool result) async {
      print("isAUTH on next");
      _isAuth = result;
      refreshUI();
    };
    splashPresenter!.isAuthOnComplete = () {
      print("is-auth on error");
    };
    splashPresenter!.isAuthOnError = (e) {
      print("is auth on error");
      print(e);
    };
    refreshUI();
  }
}

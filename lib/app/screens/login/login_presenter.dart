import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wtp_app/domain/usecase/auth/auth_token_usecase.dart';

import '../../../domain/usecase/auth/is_auth_usecase.dart';

class LoginPresenter extends Presenter {
  Function? getAuthTokenOnNext;
  Function? getAuthTokenOnComplete;
  Function? getAuthTokenOnError;
  /*is Auth*/
  Function? isAuthOnNext;
  Function? isAuthOnComplete;
  Function? isAuthOnError;

  final GetAuthTokenUseCase getLoginDetailsUseCase;
  final IsAuthUseCase isAuthUseCase;

  LoginPresenter(authRepository)
      : getLoginDetailsUseCase = GetAuthTokenUseCase(authRepository),
        isAuthUseCase = IsAuthUseCase(authRepository),
        super();

  @override
  void dispose() {
    getLoginDetailsUseCase.dispose();
    isAuthUseCase.dispose();
  }

  void login({String? email, String? password}) {
    getLoginDetailsUseCase.execute(_GetLoginDetailsUseCaseObserver(this),
        GetAuthTokenUseCaseParams(email, password));
  }

  void isAuth() {
    isAuthUseCase.execute(_IsAuthUseCaseObserver(this));
  }
}

class _GetLoginDetailsUseCaseObserver
    extends Observer<GetAuthTokenUseCaseResponse> {
  LoginPresenter loginPresenter;

  _GetLoginDetailsUseCaseObserver(this.loginPresenter);
  @override
  void onComplete() {
    loginPresenter.getAuthTokenOnComplete!();
  }

  @override
  void onError(e) {
    loginPresenter.getAuthTokenOnError!(e);
  }

  @override
  void onNext(GetAuthTokenUseCaseResponse? response) {
    loginPresenter.getAuthTokenOnNext!(response!.loginDetails);
  }
}

class _IsAuthUseCaseObserver extends Observer<IsAuthUseCaseResponse> {
  final LoginPresenter loginPresenter;

  _IsAuthUseCaseObserver(this.loginPresenter);

  @override
  void onComplete() {
    loginPresenter.isAuthOnComplete!();
  }

  @override
  void onError(e) {
    loginPresenter.isAuthOnError!(e);
  }

  @override
  void onNext(IsAuthUseCaseResponse? response) {
    loginPresenter.isAuthOnNext!(response?.isAuth);
  }
}

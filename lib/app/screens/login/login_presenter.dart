import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../domain/usecase/auth/auth_token_usecase.dart';

class LoginPresenter extends Presenter {
  Function? getAuthTokenOnNext;
  Function? getAuthTokenOnComplete;
  Function? getAuthTokenOnError;

  final GetAuthTokenUseCase getLoginDetailsUseCase;

  LoginPresenter(authRepository)
      : getLoginDetailsUseCase = GetAuthTokenUseCase(authRepository),
        super();

  @override
  void dispose() {
    getLoginDetailsUseCase.dispose();
  }

  void login({String? email, String? password}) {
    getLoginDetailsUseCase.execute(_GetLoginDetailsUseCaseObserver(this),
        GetAuthTokenUseCaseParams(email, password));
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

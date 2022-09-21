import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wtp_app/domain/usecase/auth/get_auth_token_repository.dart';

class LoginPresenter extends Presenter {
  Function? getAuthTokenOnNext;
  Function? getAuthTokenOnComplete;
  Function? getAuthTokenOnError;

  GetAuthTokenUseCase getLoginDetailsUseCase;

  LoginPresenter(loginDetailsRepository)
      : getLoginDetailsUseCase = GetAuthTokenUseCase(loginDetailsRepository);

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

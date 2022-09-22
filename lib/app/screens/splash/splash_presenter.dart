import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../domain/usecase/auth/is_auth_usecase.dart';

class SplashPresenter extends Presenter {
  /*is Auth*/
  Function? isAuthOnNext;
  Function? isAuthOnComplete;
  Function? isAuthOnError;

  final IsAuthUseCase isAuthUseCase;

  SplashPresenter(authRepository)
      : isAuthUseCase = IsAuthUseCase(authRepository),
        super();

  @override
  void dispose() {
    isAuthUseCase.dispose();
  }

  void isAuth() {
    isAuthUseCase.execute(_IsAuthUseCaseObserver(this));
  }
}

class _IsAuthUseCaseObserver extends Observer<IsAuthUseCaseResponse> {
  final SplashPresenter presenter;

  _IsAuthUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    presenter.isAuthOnComplete!();
  }

  @override
  void onError(e) {
    presenter.isAuthOnError!(e);
  }

  @override
  void onNext(IsAuthUseCaseResponse? response) {
    presenter.isAuthOnNext!(response?.isAuth);
  }
}

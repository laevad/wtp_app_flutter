import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import '../../../domain/usecase/auth/logout_usecase.dart';

class SettingsPresenter extends Presenter {
  final LogoutUseCase logoutUseCase;

  Function? logoutOnNext;
  Function? logoutOnComplete;
  Function? logoutOnError;

  SettingsPresenter() : logoutUseCase = LogoutUseCase();

  @override
  void dispose() {
    logoutUseCase.dispose();
  }

  void logout() async {
    logoutUseCase.execute(_LogoutUseCaseObserver(this));
  }
}

class _LogoutUseCaseObserver extends Observer<LogoutUseCaseResponse> {
  final SettingsPresenter presenter;

  _LogoutUseCaseObserver(this.presenter);
  @override
  void onComplete() {
    presenter.logoutOnComplete!();
  }

  @override
  void onError(e) {
    presenter.logoutOnError!(e);
  }

  @override
  void onNext(response) {
    presenter.logoutOnNext!();
  }
}

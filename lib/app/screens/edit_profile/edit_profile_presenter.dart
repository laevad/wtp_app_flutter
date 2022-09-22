import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wtp_app/domain/usecase/user/get_user_usecase.dart';

class EditProfilePresenter extends Presenter {
  Function? getUserOnComplete;
  Function? getUserOnNext;
  Function? getUserOnError;
  final GetUserUseCase getUserUseCase;

  EditProfilePresenter(userRepository)
      : getUserUseCase = GetUserUseCase(userRepository);
  @override
  void dispose() {
    getUserUseCase.dispose();
  }

  void getUser() {
    getUserUseCase.execute(_GetUserUseCaseResponseObserver(this));
  }
}

class _GetUserUseCaseResponseObserver extends Observer<GetUserUseCaseResponse> {
  final EditProfilePresenter presenter;

  _GetUserUseCaseResponseObserver(this.presenter);

  @override
  void onComplete() {
    presenter.getUserOnComplete!();
  }

  @override
  void onError(e) {
    presenter.getUserOnError!(e);
  }

  @override
  void onNext(GetUserUseCaseResponse? response) {
    presenter.getUserOnNext!(response!.user);
  }
}

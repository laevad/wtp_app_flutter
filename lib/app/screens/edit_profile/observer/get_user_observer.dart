import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../domain/usecase/user/get_user_usecase.dart';
import '../edit_profile_presenter.dart';

class GetUserUseCaseResponseObserver extends Observer<GetUserUseCaseResponse> {
  final EditProfilePresenter presenter;

  GetUserUseCaseResponseObserver(this.presenter);

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

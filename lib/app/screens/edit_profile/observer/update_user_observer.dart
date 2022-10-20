import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../domain/usecase/user/update_profile_usecase.dart';
import '../edit_profile_presenter.dart';

class UpdateProfileUseCaseObserver
    extends Observer<UpdateProfileUseCaseResponse> {
  final EditProfilePresenter presenter;

  UpdateProfileUseCaseObserver(this.presenter);
  @override
  void onComplete() {
    presenter.getUpdateUserOnComplete!();
  }

  @override
  void onError(e) {
    presenter.getUpdateUserOnError!(e);
  }

  @override
  void onNext(UpdateProfileUseCaseResponse? response) {
    presenter.getUpdateUserOnNext!(response!.user);
  }
}

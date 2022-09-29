import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wtp_app/app/screens/navigate/navigate_presenter.dart';
import 'package:wtp_app/domain/usecase/user/add_user_location_usecase.dart';

class AddUserLocationUseCaseObserver
    extends Observer<AddUserLocationUseCaseResponse> {
  final NavigatePresenter presenter;

  AddUserLocationUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    presenter.getUserLocationOnComplete!();
  }

  @override
  void onError(e) {
    presenter.getUserLocationOnError!(e);
  }

  @override
  void onNext(AddUserLocationUseCaseResponse? response) {
    presenter.getUserLocationOnNext!(response!.location);
  }
}

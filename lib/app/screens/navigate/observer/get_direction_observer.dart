import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wtp_app/app/screens/navigate/navigate_presenter.dart';
import 'package:wtp_app/domain/usecase/direction/get_direction_usercase.dart';

class GetDirectionUseCaseObserver
    extends Observer<GetDirectionUseCaseResponse> {
  final NavigatePresenter presenter;

  GetDirectionUseCaseObserver(this.presenter);
  @override
  void onComplete() {
    presenter.getDirectionOnComplete!();
  }

  @override
  void onError(e) {
    presenter.getDirectionOnError!(e);
  }

  @override
  void onNext(GetDirectionUseCaseResponse? response) {
    presenter.getDirectionOnNext!(response!.directions);
  }
}

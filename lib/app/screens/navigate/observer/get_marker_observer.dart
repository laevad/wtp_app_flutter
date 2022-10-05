import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wtp_app/app/screens/navigate/navigate_presenter.dart';
import 'package:wtp_app/domain/usecase/direction/get_marker_usecase.dart';

class GetMarkerUseCaseObserver extends Observer<GetMarkerUseCaseResponse> {
  final NavigatePresenter presenter;

  GetMarkerUseCaseObserver(this.presenter);
  @override
  void onComplete() {
    presenter.getMarkerOnComplete!();
  }

  @override
  void onError(e) {
    presenter.getMarkerOnError!(e);
  }

  @override
  void onNext(GetMarkerUseCaseResponse? response) {
    presenter.getMarkerOnNext!(response!.mapMarkerModel);
  }
}

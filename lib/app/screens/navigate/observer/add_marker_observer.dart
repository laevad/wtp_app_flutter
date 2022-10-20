import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../domain/usecase/direction/add_marker_usecase.dart';
import '../navigate_presenter.dart';

class AddMarkerUseCaseObserver extends Observer<AddMarkerUseCaseResponse> {
  final NavigatePresenter presenter;

  AddMarkerUseCaseObserver(this.presenter);
  @override
  void onComplete() {
    presenter.addMarkerOnComplete!();
  }

  @override
  void onError(e) {
    presenter.addMarkerOnError!(e);
  }

  @override
  void onNext(AddMarkerUseCaseResponse? response) {
    presenter.addMarkerOnNext!(response!.mapMarker);
  }
}

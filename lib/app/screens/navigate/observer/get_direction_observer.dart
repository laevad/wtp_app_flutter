import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../domain/usecase/direction/get_direction_usercase.dart';
import '../navigate_presenter.dart';

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

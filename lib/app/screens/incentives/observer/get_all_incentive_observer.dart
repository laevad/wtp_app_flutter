import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../domain/usecase/incentive/get_all_incentive_usecase.dart';
import '../incentives_presenter.dart';

class GetAllIncentiveUseCaseObserver
    extends Observer<GetAllIncentiveUseCaseResponse> {
  final IncentivePresenter presenter;

  GetAllIncentiveUseCaseObserver(this.presenter);
  @override
  void onComplete() {
    presenter.getIncentiveOnComplete!();
  }

  @override
  void onError(e) {
    presenter.getIncentiveOnError!(e);
  }

  @override
  void onNext(GetAllIncentiveUseCaseResponse? response) {
    presenter.getIncentiveOnNext!(response!.incentive);
  }
}

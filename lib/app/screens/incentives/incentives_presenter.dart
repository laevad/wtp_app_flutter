import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../data/repository/incentive/data_incentive_repository.dart';
import '../../../domain/usecase/incentive/get_all_incentive_usecase.dart';
import 'observer/get_all_incentive_observer.dart';

class IncentivePresenter extends Presenter {
  Function? getIncentiveOnComplete;
  Function? getIncentiveOnError;
  Function? getIncentiveOnNext;

  final GetAllIncentiveUseCase getAllIncentiveUseCase;

  IncentivePresenter(DataIncentiveRepository repository)
      : getAllIncentiveUseCase = GetAllIncentiveUseCase(repository);

  getIncentive(int page) {
    return getAllIncentiveUseCase.execute(
      GetAllIncentiveUseCaseObserver(this),
      GetAllIncentiveUseCaseParams(page),
    );
  }

  @override
  void dispose() {
    getAllIncentiveUseCase.dispose();
  }
}

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../domain/usecase/user/add_user_location_usecase.dart';
import 'observer/add_user_location_observer.dart';

class NavigatePresenter extends Presenter {
  /*location*/
  Function? getUserLocationOnNext;
  Function? getUserLocationOnError;
  Function? getUserLocationOnComplete;

  final AddUserLocationUseCase addUserLocationUseCase;

  NavigatePresenter(repository)
      : addUserLocationUseCase = AddUserLocationUseCase(repository);

  @override
  void dispose() {
    addUserLocationUseCase.dispose();
  }

  addUserLocation(double latitude, double longitude) {
    return addUserLocationUseCase.execute(
        AddUserLocationUseCaseObserver(this),
        AddUserLocationUseCaseParams(
          latitude,
          longitude,
        ));
  }
}

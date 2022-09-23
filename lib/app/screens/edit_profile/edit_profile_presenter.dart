import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../domain/repositories/login_details/user_repository.dart';
import '../../../domain/usecase/user/get_user_usecase.dart';
import '../../../domain/usecase/user/update_profile_usecase.dart';
import 'observer/get_user_observer.dart';
import 'observer/update_user_observer.dart';

class EditProfilePresenter extends Presenter implements UserRepository {
  Function? getUserOnComplete;
  Function? getUserOnNext;
  Function? getUserOnError;

  Function? getUpdateUserOnComplete;
  Function? getUpdateUserOnNext;
  Function? getUpdateUserOnError;

  final GetUserUseCase getUserUseCase;
  final UpdateProfileUseCase updateProfileUseCase;

  EditProfilePresenter(userRepository)
      : getUserUseCase = GetUserUseCase(userRepository),
        updateProfileUseCase = UpdateProfileUseCase(userRepository);
  @override
  void dispose() {
    getUserUseCase.dispose();
    updateProfileUseCase.dispose();
  }

  @override
  Future getUser() async {
    getUserUseCase.execute(GetUserUseCaseResponseObserver(this));
  }

  @override
  Future updateProfile(String name, String email, String currPass,
      String newPass, String conPass, String image) async {
    updateProfileUseCase.execute(
      UpdateProfileUseCaseObserver(this),
      UpdateProfileUseCaseParams(
          name, email, currPass, newPass, conPass, image),
    );
  }
}

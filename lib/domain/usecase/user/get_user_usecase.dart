import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../data/repository/helpers/auth/is_auth.dart';
import '../../entities/user.dart';
import '../../repositories/login_details/user_repository.dart';

class GetUserUseCase extends UseCase<GetUserUseCaseResponse, void> {
  final UserRepository userRepository;
  GetUserUseCase(this.userRepository);
  @override
  Future<Stream<GetUserUseCaseResponse?>> buildUseCaseStream(params) async {
    final controller = StreamController<GetUserUseCaseResponse>();
    try {
      final user = await userRepository.getUser();
      controller.add(GetUserUseCaseResponse(user));
      controller.close();
      logger.finest('GetUserUseCase successful');
    } catch (e) {
      logger.severe('GetUserUseCase unsuccessful');
      await IsAuth.deleteAll();
      controller.addError(e);
    }
    return controller.stream;
  }
}

class GetUserUseCaseResponse {
  final User user;
  GetUserUseCaseResponse(this.user);
}

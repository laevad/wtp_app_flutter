import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import '../../entities/user.dart';
import '../../repositories/login_details/user_repository.dart';

class UpdateProfileUseCase
    extends UseCase<UpdateProfileUseCaseResponse, UpdateProfileUseCaseParams> {
  final UserRepository userRepository;
  UpdateProfileUseCase(this.userRepository);
  @override
  Future<Stream<UpdateProfileUseCaseResponse>> buildUseCaseStream(
      UpdateProfileUseCaseParams? params) async {
    final controller = StreamController<UpdateProfileUseCaseResponse>();
    try {
      final user = await userRepository.updateProfile(
          params!.name!,
          params.email!,
          params.currPass!,
          params.newPass!,
          params.conPass!,
          params.image);
      logger.finest('UpdateProfileUseCase success');
      controller.add(UpdateProfileUseCaseResponse(user));
      controller.close();
    } catch (e) {
      controller.addError(e);
      logger.severe('UpdateProfileUseCase unsuccessful');
    }
    return controller.stream;
  }
}

class UpdateProfileUseCaseResponse {
  final User user;

  UpdateProfileUseCaseResponse(this.user);
}

class UpdateProfileUseCaseParams {
  final String? name;
  final String? email;
  final String? currPass;
  final String? newPass;
  final String? conPass;
  final String image;

  UpdateProfileUseCaseParams(this.name, this.email, this.currPass, this.newPass,
      this.conPass, this.image);
}

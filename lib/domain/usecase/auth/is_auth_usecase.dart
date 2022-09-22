import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wtp_app/domain/repositories/login_details/auth_repository.dart';

import '../../../data/repository/auth/data_auth_token_repository.dart';

class IsAuthUseCase extends UseCase<IsAuthUseCaseResponse, void> {
  final AuthRepository authRepository;

  IsAuthUseCase(this.authRepository);
  @override
  Future<Stream<IsAuthUseCaseResponse?>> buildUseCaseStream(params) async {
    final controller = StreamController<IsAuthUseCaseResponse>();
    try {
      bool isAuth = await DataAuthRepository().isAuthenticated();
      controller.add(IsAuthUseCaseResponse(isAuth));
      logger.finest('Is Authenticated successful.');
      controller.close();
    } catch (e) {
      logger.severe('Is Authenticated fail.');
      controller.addError(e);
    }
    return controller.stream;
  }
}

class IsAuthUseCaseResponse {
  final bool isAuth;
  IsAuthUseCaseResponse(this.isAuth);
}

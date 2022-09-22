import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../entities/auth_token.dart';
import '../../repositories/login_details/auth_repository.dart';

class GetAuthTokenUseCase
    extends UseCase<GetAuthTokenUseCaseResponse, GetAuthTokenUseCaseParams> {
  final AuthRepository loginDetailsRepository;

  GetAuthTokenUseCase(this.loginDetailsRepository);
  @override
  Future<Stream<GetAuthTokenUseCaseResponse>> buildUseCaseStream(
      GetAuthTokenUseCaseParams? params) async {
    final controller = StreamController<GetAuthTokenUseCaseResponse>();
    try {
      final loginDetails = await loginDetailsRepository.getAuthToken(
          params!.email!, params.password!);
      controller.add(GetAuthTokenUseCaseResponse(loginDetails));
      controller.close();
    } catch (e) {
      controller.addError(e);
      logger.severe('GetUserUseCase unsuccessful.');
    }
    return controller.stream;
  }
}

class GetAuthTokenUseCaseResponse {
  final AuthToken? loginDetails;
  GetAuthTokenUseCaseResponse(this.loginDetails);
}

class GetAuthTokenUseCaseParams {
  final String? email;
  final String? password;
  GetAuthTokenUseCaseParams(this.email, this.password);
}

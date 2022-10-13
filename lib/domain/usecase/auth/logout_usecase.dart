import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../data/repository/helpers/auth/is_auth.dart';

class LogoutUseCase extends UseCase<LogoutUseCaseResponse, void> {
  FlutterSecureStorage storage = const FlutterSecureStorage();

  @override
  Future<Stream<LogoutUseCaseResponse?>> buildUseCaseStream(params) async {
    final controller = StreamController<LogoutUseCaseResponse>();
    try {
      await IsAuth.deleteKey(key: 'token');
      await IsAuth.deleteKey(key: 'id');
      await IsAuth.deleteKey(key: 'user_id');
      controller.close();
    } catch (e) {
      controller.addError(e);
    }
    return controller.stream;
  }
}

class LogoutUseCaseResponse {
  LogoutUseCaseResponse();
}

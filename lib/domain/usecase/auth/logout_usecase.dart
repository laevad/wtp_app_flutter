import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LogoutUseCase extends UseCase<LogoutUseCaseResponse, void> {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  AndroidOptions _secureOption() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  @override
  Future<Stream<LogoutUseCaseResponse?>> buildUseCaseStream(params) async {
    final controller = StreamController<LogoutUseCaseResponse>();
    try {
      await storage.deleteAll(aOptions: _secureOption());
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

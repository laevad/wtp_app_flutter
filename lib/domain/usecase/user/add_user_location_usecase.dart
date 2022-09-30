import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../data/repository/user/data_user_location_repository.dart';

class AddUserLocationUseCase extends UseCase<AddUserLocationUseCaseResponse,
    AddUserLocationUseCaseParams> {
  final DataUserLocationRepository repository;

  AddUserLocationUseCase(this.repository);
  @override
  Future<Stream<AddUserLocationUseCaseResponse>> buildUseCaseStream(
      AddUserLocationUseCaseParams? params) async {
    final controller = StreamController<AddUserLocationUseCaseResponse>();
    try {
      await repository.addLocation(
        params!.latitude,
        params.longitude,
      );
      logger.finest('AddUserLocationUseCase successful');
      controller.close();
    } catch (e) {
      logger.severe('AddUserLocationUseCase unsuccessful');
      controller.addError(e);
    }
    return controller.stream;
  }
}

class AddUserLocationUseCaseResponse {
  AddUserLocationUseCaseResponse();
}

class AddUserLocationUseCaseParams {
  final double latitude;
  final double longitude;

  AddUserLocationUseCaseParams(this.latitude, this.longitude);
}

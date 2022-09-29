import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wtp_app/domain/entities/location.dart';
import 'package:wtp_app/domain/repositories/user/user_location_repository.dart';

class AddUserLocationUseCase extends UseCase<AddUserLocationUseCaseResponse,
    AddUserLocationUseCaseParams> {
  final UserLocationRepository repository;

  AddUserLocationUseCase(this.repository);
  @override
  Future<Stream<AddUserLocationUseCaseResponse?>> buildUseCaseStream(
      AddUserLocationUseCaseParams? params) async {
    final controller = StreamController<AddUserLocationUseCaseResponse>();
    try {
      final location = await repository.addLocation(
        params!.latitude,
        params.longitude,
      );
      controller.add(AddUserLocationUseCaseResponse(location));
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
  final LocationModel location;

  AddUserLocationUseCaseResponse(this.location);
}

class AddUserLocationUseCaseParams {
  final double latitude;
  final double longitude;

  AddUserLocationUseCaseParams(this.latitude, this.longitude);
}

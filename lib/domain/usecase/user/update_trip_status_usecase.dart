import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../data/repository/trip/data_trip_repository.dart';

class UpdateTripStatusUseCase
    extends UseCase<UpdateTripStatusUseCaseResponse, void> {
  final DataTripRepository repository;

  UpdateTripStatusUseCase(this.repository);
  @override
  Future<Stream<UpdateTripStatusUseCaseResponse?>> buildUseCaseStream(
      void params) async {
    final controller = StreamController<UpdateTripStatusUseCaseResponse>();
    try {
      await repository.updateStatus();
      controller.close();
      logger.finest('UpdateTripStatusUseCase successfully');
    } catch (e) {
      controller.addError(e);
      logger.finest('UpdateTripStatusUseCase unsuccessful');
    }
    return controller.stream;
  }
}

class UpdateTripStatusUseCaseResponse {
  UpdateTripStatusUseCaseResponse();
}

import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../data/repository/trip/data_trip_repository.dart';

class UpdateTripStatusToOnGoingUseCase extends UseCase<
    UpdateTripStatusUseCaseResponse, UpdateTripStatusUseCaseParams> {
  final DataTripRepository repository;

  UpdateTripStatusToOnGoingUseCase(this.repository);
  @override
  Future<Stream<UpdateTripStatusUseCaseResponse?>> buildUseCaseStream(
      UpdateTripStatusUseCaseParams? params) async {
    final controller = StreamController<UpdateTripStatusUseCaseResponse>();
    try {
      await repository.updateStatus(params!.bookingId, params.statusId);
      controller.close();
      logger.finest('UpdateTripStatusUseCase successfully');
    } catch (e) {
      controller.addError(e);
      logger.severe('UpdateTripStatusUseCase unsuccessful');
    }
    return controller.stream;
  }
}

class UpdateTripStatusUseCaseParams {
  final String bookingId;
  final int statusId;

  UpdateTripStatusUseCaseParams(this.bookingId, this.statusId);
}

class UpdateTripStatusUseCaseResponse {
  UpdateTripStatusUseCaseResponse();
}

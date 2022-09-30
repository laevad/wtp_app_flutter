import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../data/repository/user/data_user_location_repository.dart';

class UpdateTripStatusToCompleteUseCase extends UseCase<
    UpdateTripStatusToCompleteUseCaseResponse,
    UpdateTripStatusToCompleteUseCaseParams> {
  final DataUserLocationRepository repository;

  UpdateTripStatusToCompleteUseCase(this.repository);
  @override
  Future<Stream<UpdateTripStatusToCompleteUseCaseResponse?>> buildUseCaseStream(
      UpdateTripStatusToCompleteUseCaseParams? params) async {
    final controller =
        StreamController<UpdateTripStatusToCompleteUseCaseResponse>();
    try {
      await repository.updateStatus(params!.bookingId, params.statusId);
      controller.close();
      logger.finest("UpdateTripStatusToCompleteUseCase successful");
    } catch (e) {
      controller.addError(e);
      logger.severe("UpdateTripStatusToCompleteUseCase unsuccessful");
    }
    return controller.stream;
  }
}

class UpdateTripStatusToCompleteUseCaseResponse {
  UpdateTripStatusToCompleteUseCaseResponse();
}

class UpdateTripStatusToCompleteUseCaseParams {
  final String bookingId;
  final int statusId;

  UpdateTripStatusToCompleteUseCaseParams(this.bookingId, this.statusId);
}

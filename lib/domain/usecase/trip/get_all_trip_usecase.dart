import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../entities/trip.dart';
import '../../repositories/trip/trip_repository.dart';

class GetAllTripUseCase
    extends UseCase<GetAllTripUseCaseResponse, GetAllTripUseCaseParams> {
  final TripRepository repository;

  GetAllTripUseCase(this.repository);
  @override
  Future<Stream<GetAllTripUseCaseResponse?>> buildUseCaseStream(params) async {
    final controller = StreamController<GetAllTripUseCaseResponse>();
    try {
      final trip =
          await repository.getAllTrip(params!.page, params.tripStatus!);
      controller.add(GetAllTripUseCaseResponse(trip));
      logger.finest('GetAllTripUseCase success');
      controller.close();
    } catch (e) {
      logger.severe('GetAllTripUseCase error');
      controller.addError(e);
    }
    return controller.stream;
  }
}

class GetAllTripUseCaseParams {
  final int page;
  final String? tripStatus;

  GetAllTripUseCaseParams(this.page, this.tripStatus);
}

class GetAllTripUseCaseResponse {
  final TripModel trip;

  GetAllTripUseCaseResponse(this.trip);
}

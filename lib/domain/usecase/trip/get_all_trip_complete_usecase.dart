import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../entities/trip.dart';
import '../../repositories/trip/trip_repository.dart';

class GetAllTripCompleteUseCase extends UseCase<
    GetAllTripCompleteUseCaseResponse, GetAllTripCompleteUseCaseParams> {
  final TripRepository repository;

  GetAllTripCompleteUseCase(this.repository);
  @override
  Future<Stream<GetAllTripCompleteUseCaseResponse?>> buildUseCaseStream(
      params) async {
    final controller = StreamController<GetAllTripCompleteUseCaseResponse>();
    try {
      final trip = await repository.getAllTripComplete(params!.page);
      controller.add(GetAllTripCompleteUseCaseResponse(trip));
      logger.finest('GetAllTripUseCase success');
      controller.close();
    } catch (e) {
      logger.severe('GetAllTripUseCase error');
      controller.addError(e);
    }
    return controller.stream;
  }
}

class GetAllTripCompleteUseCaseParams {
  final int page;

  GetAllTripCompleteUseCaseParams(this.page);
}

class GetAllTripCompleteUseCaseResponse {
  final TripModel trip;

  GetAllTripCompleteUseCaseResponse(this.trip);
}

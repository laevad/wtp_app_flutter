import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../entities/direction.dart';
import '../../repositories/direction/direction_repository.dart';

class GetDirectionUseCase
    extends UseCase<GetDirectionUseCaseResponse, GetDirectionUseCaseParams> {
  final DirectionRepository repository;

  GetDirectionUseCase(this.repository);
  @override
  Future<Stream<GetDirectionUseCaseResponse?>> buildUseCaseStream(
      GetDirectionUseCaseParams? params) async {
    final controller = StreamController<GetDirectionUseCaseResponse>();
    try {
      final directions =
          await repository.getDirections(params!.origin, params.destination);
      controller.add(GetDirectionUseCaseResponse(directions));

      logger.finest("GetDirectionUseCase successful");
    } catch (e) {
      controller.addError(e);
      logger.severe("GetDirectionUseCase unsuccessful");
    }
    return controller.stream;
  }
}

class GetDirectionUseCaseParams {
  final LatLng origin;
  final LatLng destination;

  GetDirectionUseCaseParams(this.origin, this.destination);
}

class GetDirectionUseCaseResponse {
  final Directions directions;
  GetDirectionUseCaseResponse(this.directions);
}

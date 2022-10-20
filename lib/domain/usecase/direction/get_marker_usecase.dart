import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../entities/map_marker.dart';
import '../../repositories/direction/marker_repository.dart';

class GetMarkerUseCase
    extends UseCase<GetMarkerUseCaseResponse, GetMarkerUseCaseParams> {
  final MarkerRepository markerRepository;

  GetMarkerUseCase(this.markerRepository);
  @override
  Future<Stream<GetMarkerUseCaseResponse?>> buildUseCaseStream(
      GetMarkerUseCaseParams? params) async {
    final controller = StreamController<GetMarkerUseCaseResponse>();
    try {
      final res = await markerRepository.getMarkers(params!.bookingId);
      controller.add(GetMarkerUseCaseResponse(res));
      logger.finest("GetMarkerUseCase success");
    } catch (e) {
      controller.addError(e);
      logger.severe("GetMarkerUseCase success");
    }
    return controller.stream;
  }
}

class GetMarkerUseCaseParams {
  final String bookingId;

  GetMarkerUseCaseParams(this.bookingId);
}

class GetMarkerUseCaseResponse {
  final MapMarkerModel mapMarkerModel;

  GetMarkerUseCaseResponse(this.mapMarkerModel);
}

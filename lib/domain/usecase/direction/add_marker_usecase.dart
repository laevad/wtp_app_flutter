import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wtp_app/domain/entities/map_marker.dart';
import 'package:wtp_app/domain/repositories/direction/marker_repository.dart';

class AddMarkerUseCase
    extends UseCase<AddMarkerUseCaseResponse, AddMarkerUseCaseParams> {
  final MarkerRepository repository;

  AddMarkerUseCase(this.repository);
  @override
  Future<Stream<AddMarkerUseCaseResponse?>> buildUseCaseStream(
      AddMarkerUseCaseParams? params) async {
    final controller = StreamController<AddMarkerUseCaseResponse>();
    try {
      final mapMarker = await repository.addMarker(
          params!.bookingId, params.latitude, params.longitude);
      controller.add(AddMarkerUseCaseResponse(mapMarker));
      logger.finest("AddMarkerUseCase successful");
    } catch (e) {
      controller.addError(e);
      logger.severe("AddMarkerUseCase unsuccessful");
    }
    return controller.stream;
  }
}

class AddMarkerUseCaseParams {
  final String bookingId;
  final double latitude;
  final double longitude;

  AddMarkerUseCaseParams(this.bookingId, this.latitude, this.longitude);
}

class AddMarkerUseCaseResponse {
  final MapMarker mapMarker;

  AddMarkerUseCaseResponse(this.mapMarker);
}

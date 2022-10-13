import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wtp_app/domain/entities/trip_start_end.dart';
import 'package:wtp_app/domain/repositories/expense/expense_repository.dart';

class GetTripStartEndUseCase
    extends UseCase<GetTripStartEndUseCaseResponse, void> {
  final ExpenseRepository expenseRepository;

  GetTripStartEndUseCase(this.expenseRepository);

  @override
  Future<Stream<GetTripStartEndUseCaseResponse?>> buildUseCaseStream(
      void params) async {
    final controller = StreamController<GetTripStartEndUseCaseResponse>();

    try {
      final tripStartEndModel = await expenseRepository.getTripStartEndModel();
      controller.add(GetTripStartEndUseCaseResponse(tripStartEndModel));
      logger.finest("tripStartEndModel successful");
      controller.close();
    } catch (e) {
      controller.addError(e);
      logger.severe("GetTripStartEndUseCase unsuccessful");
    }

    return controller.stream;
  }
}

class GetTripStartEndUseCaseResponse {
  final TripStartEndModel tripStartEndModel;

  GetTripStartEndUseCaseResponse(this.tripStartEndModel);
}

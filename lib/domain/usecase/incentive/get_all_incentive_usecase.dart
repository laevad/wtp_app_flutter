import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wtp_app/domain/repositories/incentive/incentive_repository.dart';

import '../../entities/incentive.dart';

class GetAllIncentiveUseCase extends UseCase<GetAllIncentiveUseCaseResponse,
    GetAllIncentiveUseCaseParams> {
  final IncentiveRepository repository;

  GetAllIncentiveUseCase(this.repository);
  @override
  Future<Stream<GetAllIncentiveUseCaseResponse?>> buildUseCaseStream(
      GetAllIncentiveUseCaseParams? params) async {
    final controller = StreamController<GetAllIncentiveUseCaseResponse>();
    try {
      final res = await repository.getAllIncentive(params!.page);
      controller.add(GetAllIncentiveUseCaseResponse(res));
      logger.finest("GetAllIncentiveUseCase successful");
      controller.close();
    } catch (e) {
      controller.addError(e);
      logger.severe("GetAllIncentiveUseCase unsuccessful");
    }
    return controller.stream;
  }
}

class GetAllIncentiveUseCaseParams {
  final int page;

  GetAllIncentiveUseCaseParams(this.page);
}

class GetAllIncentiveUseCaseResponse {
  final IncentiveModel incentive;
  GetAllIncentiveUseCaseResponse(this.incentive);
}

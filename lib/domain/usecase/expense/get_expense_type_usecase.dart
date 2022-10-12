import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wtp_app/domain/entities/expense_type.dart';
import 'package:wtp_app/domain/repositories/expense/expense_repository.dart';

class GetExpenseTypeUseCase
    extends UseCase<GetExpenseTypeUseCaseResponse, void> {
  final ExpenseRepository repository;

  GetExpenseTypeUseCase(this.repository);
  @override
  Future<Stream<GetExpenseTypeUseCaseResponse?>> buildUseCaseStream(
      void params) async {
    final controller = StreamController<GetExpenseTypeUseCaseResponse>();

    try {
      final typeModel = await repository.getExpenseTypeModel();
      controller.add(GetExpenseTypeUseCaseResponse(typeModel));
      controller.close();
    } catch (error) {
      controller.addError(error);
      logger.severe("GetExpenseTypeUseCase unsuccessful");
    }

    return controller.stream;
  }
}

class GetExpenseTypeUseCaseResponse {
  final ExpenseTypeModel typeModel;

  GetExpenseTypeUseCaseResponse(this.typeModel);
}

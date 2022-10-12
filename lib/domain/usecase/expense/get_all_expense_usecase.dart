import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wtp_app/domain/entities/expense.dart';
import 'package:wtp_app/domain/repositories/expense/expense_repository.dart';

class GetAllExpenseUseCase
    extends UseCase<GetAllExpenseUseCaseResponse, GetAllExpenseUseCaseParams> {
  final ExpenseRepository repository;

  GetAllExpenseUseCase(this.repository);
  @override
  Future<Stream<GetAllExpenseUseCaseResponse?>> buildUseCaseStream(
      GetAllExpenseUseCaseParams? params) async {
    final controller = StreamController<GetAllExpenseUseCaseResponse>();

    try {
      final expense = await repository.getAllIncentive(params!.page);
      controller.add(GetAllExpenseUseCaseResponse(expense));
      logger.finest("GetAllExpenseUseCase success");
      controller.close();
    } catch (e) {
      controller.addError(e);
      logger.severe("GetAllExpenseUseCase unsuccessful");
    }

    return controller.stream;
  }
}

class GetAllExpenseUseCaseParams {
  final int page;

  GetAllExpenseUseCaseParams(this.page);
}

class GetAllExpenseUseCaseResponse {
  final ExpenseModel expense;

  GetAllExpenseUseCaseResponse(this.expense);
}

import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wtp_app/domain/entities/expense.dart';
import 'package:wtp_app/domain/repositories/expense/expense_repository.dart';

class AddExpenseUseCase
    extends UseCase<AddExpenseUseCaseResponse, AddExpenseUseCaseParams> {
  final ExpenseRepository repository;

  AddExpenseUseCase(this.repository);
  @override
  Future<Stream<AddExpenseUseCaseResponse?>> buildUseCaseStream(
      AddExpenseUseCaseParams? params) async {
    final controller = StreamController<AddExpenseUseCaseResponse>();
    final expenseModel = await repository.addExpense(params!.expenseTypeId!,
        params.bookingId, params.amount, params.description);

    controller.add(AddExpenseUseCaseResponse(expenseModel));
    logger.finest("AddExpenseUseCase success");
    controller.close();
    try {} catch (e) {
      controller.addError(e);
      logger.severe("AddExpenseUseCase unsuccessful");
    }
    return controller.stream;
  }
}

class AddExpenseUseCaseParams {
  final String? expenseTypeId;
  final String bookingId;
  final String amount;
  final String description;

  AddExpenseUseCaseParams(
    this.expenseTypeId,
    this.bookingId,
    this.amount,
    this.description,
  );
}

class AddExpenseUseCaseResponse {
  final ExpenseModel expenseModel;

  AddExpenseUseCaseResponse(this.expenseModel);
}

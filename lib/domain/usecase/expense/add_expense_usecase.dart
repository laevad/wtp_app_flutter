import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../entities/expense.dart';
import '../../repositories/expense/expense_repository.dart';

class AddExpenseUseCase
    extends UseCase<AddExpenseUseCaseResponse, AddExpenseUseCaseParams> {
  final ExpenseRepository repository;

  AddExpenseUseCase(this.repository);
  @override
  Future<Stream<AddExpenseUseCaseResponse?>> buildUseCaseStream(
      AddExpenseUseCaseParams? params) async {
    final controller = StreamController<AddExpenseUseCaseResponse>();
    final expenseModel = await repository.addExpense(
      params!.expenseTypeId!,
      params.bookingId,
      params.amount,
      params.description,
      params.image_path!,
    );

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
  /*image_path*/
  final String? image_path;

  AddExpenseUseCaseParams(
    this.expenseTypeId,
    this.bookingId,
    this.amount,
    this.description,
    this.image_path,
  );
}

class AddExpenseUseCaseResponse {
  final ExpenseModel expenseModel;

  AddExpenseUseCaseResponse(this.expenseModel);
}

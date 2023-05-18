import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart' as clean_architecture;

import '../../../data/repository/expense/data_expense_repository.dart';
import '../../utils/constant.dart';
import '../../widgets/expense/custom_expand_tile_expense.dart';
import 'expense_controller.dart';

class ExpenseView extends clean_architecture.View {
  const ExpenseView({Key? key}) : super(key: key);

  @override
  ExpenseViewState createState() => ExpenseViewState();
}

class ExpenseViewState extends clean_architecture.ViewState<ExpenseView, ExpenseController> {
  ExpenseViewState() : super(ExpenseController(DataExpenseRepository()));

  @override
  Widget get view => clean_architecture.ControlledWidgetBuilder<ExpenseController>(
        builder: (context, controller) {
          if (controller.expense == null) {
            return Center(
              child: CircularProgressIndicator(
                color: Constant.lightColorScheme.primary,
              ),
            );
          }
          return Scaffold(
            key: globalKey,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Constant.lightColorScheme.primaryContainer,
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () => controller.addExpenseView(),
                    icon: Icon(
                      Icons.add_circle_outlined,
                      size: 40,
                      color: Constant.lightColorScheme.onPrimaryContainer,
                    )),
              ],
              title: const Text(
                'Expense Report',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1),
                      child: ListView.builder(
                        controller: controller.scrollController,
                        itemCount: controller.expense!.length,
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return CustomExpandTileExpense(
                            index: (index + 1).toString(),
                            expense: controller.expense![index],
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    width: double.infinity,
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Total :  ${controller.amount.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                  ),
                ],
              ),
            ),
          );
        },
      );
}

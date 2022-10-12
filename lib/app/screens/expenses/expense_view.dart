import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wtp_app/app/screens/expenses/expense_controller.dart';
import 'package:wtp_app/app/widgets/expense/custom_expand_tile_expense.dart';
import 'package:wtp_app/data/repository/expense/data_expense_repository.dart';

import '../../utils/constant.dart';

class ExpenseView extends View {
  const ExpenseView({Key? key}) : super(key: key);

  @override
  ExpenseViewState createState() => ExpenseViewState();
}

class ExpenseViewState extends ViewState<ExpenseView, ExpenseController> {
  ExpenseViewState() : super(ExpenseController(DataExpenseRepository()));

  @override
  // TODO: implement view
  Widget get view => ControlledWidgetBuilder<ExpenseController>(
        builder: (context, controller) {
          if (controller.expense == null) {
            return Container();
          }
          return Scaffold(
            key: globalKey,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Constant.lightColorScheme.primaryContainer,
              centerTitle: true,
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
                        itemCount: controller.expense!.length,
                        physics: const BouncingScrollPhysics(),
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
                          'Total :  ${controller.amount}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              shape: CircleBorder(
                  side: BorderSide(
                color: Constant.lightColorScheme.onSecondaryContainer,
              )),
              onPressed: () {
                showModalBottomSheet(
                  enableDrag: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return Container(
                      height: MediaQuery.of(context).size.height / 4,
                      decoration: BoxDecoration(
                          color: Constant.lightColorScheme.primaryContainer,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25))),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Close'),
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Icon(Icons.add),
            ),
          );
        },
      );
}

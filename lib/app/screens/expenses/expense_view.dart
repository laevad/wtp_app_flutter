import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wtp_app/app/screens/expenses/expense_controller.dart';

import '../../utils/constant.dart';

class ExpenseView extends View {
  const ExpenseView({Key? key}) : super(key: key);

  @override
  ExpenseViewState createState() => ExpenseViewState();
}

class ExpenseViewState extends ViewState<ExpenseView, ExpenseController> {
  ExpenseViewState() : super(ExpenseController());

  @override
  // TODO: implement view
  Widget get view => ControlledWidgetBuilder<ExpenseController>(
        builder: (context, controller) {
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
              child: Container(),
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
                      height: 300,
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

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
          );
        },
      );
}

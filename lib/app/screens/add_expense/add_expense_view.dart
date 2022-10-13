import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wtp_app/app/screens/add_expense/add_expense_controller.dart';

class AddExpenseView extends View {
  static String routeName = '/add-expense';
  const AddExpenseView({Key? key}) : super(key: key);

  @override
  AddExpenseViewState createState() => AddExpenseViewState();
}

class AddExpenseViewState
    extends ViewState<AddExpenseView, AddExpenseController> {
  AddExpenseViewState() : super(AddExpenseController());

  @override
  // TODO: implement view
  Widget get view => ControlledWidgetBuilder(
        builder: (context, controller) {
          return Scaffold(
            key: globalKey,
            appBar: AppBar(),
          );
        },
      );
}

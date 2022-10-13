import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtp_app/app/screens/add_expense/add_expense_controller.dart';

import '../../../data/repository/expense/data_expense_repository.dart';
import '../../utils/constant.dart';

class AddExpenseView extends View {
  static String routeName = '/add-expense';
  const AddExpenseView({Key? key}) : super(key: key);

  @override
  AddExpenseViewState createState() => AddExpenseViewState();
}

class AddExpenseViewState
    extends ViewState<AddExpenseView, AddExpenseController> {
  AddExpenseViewState() : super(AddExpenseController(DataExpenseRepository()));

  @override
  // TODO: implement view
  Widget get view => ControlledWidgetBuilder<AddExpenseController>(
        builder: (context, controller) {
          if (controller.expenseType == null ||
              controller.tripStartEnd == null) {
            return Center(
              child: CircularProgressIndicator(
                color: Constant.lightColorScheme.primary,
              ),
            );
          }
          return Theme(
            data: ThemeData(
                colorScheme: Constant.lightColorScheme,
                textTheme: GoogleFonts.openSansTextTheme().apply(
                    displayColor: const Color(0xFF383838),
                    bodyColor: const Color(0xFF383838)),
                useMaterial3: true),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Scaffold(
                key: globalKey,
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text('Travel Expense Report'),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            margin: const EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                            ),
                            child: DropdownButton(
                              underline: const SizedBox(),
                              hint: const Text('Select Expense Type'),
                              value: controller.selectedExpenseType,
                              isExpanded: true,
                              items: controller.expenseType!.map(
                                (e) {
                                  return DropdownMenuItem(
                                    value: e.id.toString(),
                                    child: Text(e.name.toString()),
                                  );
                                },
                              ).toList(),
                              onChanged: (value) {
                                setState(() {
                                  controller.setSelectedExpenseType = value!;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            margin: const EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                            ),
                            child: DropdownButton(
                              underline: const SizedBox(),
                              hint: const Text('Select Trip'),
                              isExpanded: true,
                              value: controller.selectedTrip,
                              items: controller.tripStartEnd!.map(
                                (e) {
                                  return DropdownMenuItem(
                                    alignment: Alignment.topCenter,
                                    value: e.id,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${e.start}",
                                            softWrap: true,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          " ---   ",
                                          style: TextStyle(
                                            color: Constant
                                                .lightColorScheme.primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "${e.end}",
                                            softWrap: true,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ).toList(),
                              onChanged: (value) {
                                setState(() {
                                  controller.setSelectedTrip = value!;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              controller: controller.amountTextController,
                              decoration: InputDecoration(
                                hintText: 'Amount',
                                errorText:
                                    controller.expenseError?.amountError == null
                                        ? null
                                        : controller.expenseError!.amountError
                                            .toString(),
                                border: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            child: TextField(
                              textInputAction: TextInputAction.done,
                              minLines: 2,
                              maxLines: 5,
                              controller: controller.descriptionTextController,
                              decoration: InputDecoration(
                                hintText: 'Description',
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 5.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                                onPressed: () => setState(() {
                                      controller.addExpense();
                                    }),
                                child: const Text(
                                  "Add Expense",
                                  style: TextStyle(fontSize: 18),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
}

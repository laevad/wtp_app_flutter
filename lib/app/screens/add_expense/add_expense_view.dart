import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtp_app/app/screens/add_expense/add_expense_controller.dart';

import '../../utils/constant.dart';

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
  Widget get view => ControlledWidgetBuilder<AddExpenseController>(
        builder: (context, controller) {
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
                body: Padding(
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
                            isExpanded: true,
                            items: [],
                            onChanged: (value) {
                              print(value);
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
                            items: [],
                            onChanged: (value) {
                              print(value);
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          child: const TextField(
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              hintText: 'Amount',
                              border: OutlineInputBorder(
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
                          child: const TextField(
                            textInputAction: TextInputAction.done,
                            minLines: 2,
                            maxLines: 5,
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
                              onPressed: () {},
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
          );
        },
      );
}

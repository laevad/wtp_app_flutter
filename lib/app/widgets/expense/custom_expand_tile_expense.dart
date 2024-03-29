import 'package:flutter/material.dart';

import '../../../domain/entities/expense.dart';
import '../../utils/constant.dart';

class CustomExpandTileExpense extends StatelessWidget {
  final String? index;
  final Expense? expense;
  const CustomExpandTileExpense({Key? key, this.index, this.expense})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("====================");
    print(Constant.urlImage);
    return Card(
      child: ExpansionTile(
        collapsedTextColor: Colors.red,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Php ${expense!.amount?.toStringAsFixed(2)}",
              style: TextStyle(
                color: Constant.lightColorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            Text("${expense!.date}",
                style: TextStyle(
                  color: Constant.lightColorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                )),
          ],
        ),
        children: [
          ListTile(
            title: Text(
              softWrap: true,
              expense!.note != null
                  ? "${expense!.note?.toUpperCase()}"
                  : "${expense!.expenseType?.toString()}",
              maxLines: 3,
              style: TextStyle(
                color: Constant.lightColorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ),
          /*image_path circle*/
          ListTile(
            title: expense!.imagePath != null
                ? CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                      /*get url*/
                      Constant.urlImage + '' + expense!.imagePath!,
                    ),
                  )
                : SizedBox(),
          ),
        ],
      ),
    );
  }
}

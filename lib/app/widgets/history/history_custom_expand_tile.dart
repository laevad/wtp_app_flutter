import 'package:flutter/material.dart';
import 'package:wtp_app/domain/entities/incentive.dart';

import '../../utils/constant.dart';

class HistoryCustomExpandTile extends StatelessWidget {
  final String? index;
  final Incentive? incentive;
  const HistoryCustomExpandTile({Key? key, this.index, this.incentive})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        collapsedTextColor: Colors.red,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Php ${incentive!.amount.toString()}",
              style: TextStyle(
                color: Constant.lightColorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            Text("${incentive!.date}",
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
              "${incentive!.note?.toUpperCase()}",
              maxLines: 3,
              style: TextStyle(
                color: Constant.lightColorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

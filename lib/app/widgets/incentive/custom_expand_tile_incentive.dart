import 'package:flutter/material.dart';

import '../../../domain/entities/incentive.dart';
import '../../utils/constant.dart';

class CustomExpandTileIncentive extends StatelessWidget {
  final String? index;
  final Incentive? incentive;
  const CustomExpandTileIncentive({Key? key, this.index, this.incentive})
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
              "Php ${incentive!.amount?.toStringAsFixed(2)}",
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
              incentive!.note != null
                  ? "${incentive!.note?.toUpperCase()}"
                  : 'N/A',
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

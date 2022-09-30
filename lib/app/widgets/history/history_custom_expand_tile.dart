import 'package:flutter/material.dart';

import '../../utils/constant.dart';

class HistoryCustomExpandTile extends StatelessWidget {
  final String? index;
  const HistoryCustomExpandTile({Key? key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        collapsedTextColor: Colors.red,
        title: Text(
          'PHP 300',
          style: TextStyle(
            color: Constant.lightColorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
        children: [
          ListTile(
            title: Text(
              'Carmen, CDO\n-',
              style: TextStyle(
                color: Constant.lightColorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              'Cogon Public Market',
              style: TextStyle(
                color: Constant.lightColorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

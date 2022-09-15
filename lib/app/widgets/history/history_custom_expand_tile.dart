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
          'sample history $index',
          style: TextStyle(
            color: Constant.lightColorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
            ),
            title: Text(
              'Davidkun',
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

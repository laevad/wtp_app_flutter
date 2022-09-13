import 'package:flutter/material.dart';

class TripCustomExpandTile extends StatelessWidget {
  final String? index;
  const TripCustomExpandTile({Key? key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        collapsedTextColor: Colors.red,
        title: Text('sample trip $index'),
        children: const [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
            ),
            title: Text('Davidkun'),
          ),
        ],
      ),
    );
  }
}

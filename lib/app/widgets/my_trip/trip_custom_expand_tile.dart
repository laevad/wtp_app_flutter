import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:wtp_app/app/utils/constant.dart';

class TripCustomExpandTile extends StatelessWidget {
  final String? index;
  const TripCustomExpandTile({Key? key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
          // initiallyExpanded: true,
          collapsedTextColor: Colors.red,
          title: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 18),
                      child: Text('John Client'),
                    )
                  ],
                ),
                const Text('47km'),
              ],
            ),
          ),
          children: [
            ListTile(
              leading: FittedBox(
                child: Text(
                  'CDO',
                  style: TextStyle(
                    fontSize: 18,
                    color: Constant.lightColorScheme.primary,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: DottedLine(
                  dashLength: 5,
                  lineThickness: 3,
                  direction: Axis.vertical,
                  lineLength: 30,
                  dashColor: Constant.lightColorScheme.primary,
                ),
              ),
            ),
            ListTile(
              leading: FittedBox(
                child: Text(
                  'Iligan',
                  style: TextStyle(
                    fontSize: 18,
                    color: Constant.lightColorScheme.primary,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Constant.lightColorScheme.inversePrimary),
                  ),
                  child: Text(
                    'Navigate',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Constant.lightColorScheme.onPrimaryContainer,
                    ),
                  ),
                )
              ],
            ),
          ]),
    );
  }
}

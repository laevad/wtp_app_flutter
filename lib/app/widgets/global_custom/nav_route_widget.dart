import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import '../../utils/constant.dart';

class NavRouteWidget extends StatelessWidget {
  final String? source;
  final String? destination;
  final String? btnText;
  final Function? onPressed;
  final String? status;
  const NavRouteWidget({
    Key? key,
    this.source,
    this.destination,
    this.btnText,
    this.onPressed,
    this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: [
          Expanded(
              child: Row(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Icon(
                      Icons.pin_drop,
                      color: Constant.lightColorScheme.primary,
                    ),
                  ),
                  DottedLine(
                    dashLength: 5,
                    lineThickness: 3,
                    direction: Axis.vertical,
                    lineLength: 100,
                    dashColor: Constant.lightColorScheme.primary,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Icon(
                      Icons.navigation,
                      color: Constant.lightColorScheme.primary,
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              destination.toString(),
                              softWrap: true,
                              maxLines: 3,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 14,
                                color:
                                    Constant.lightColorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Divider(
                        height: 40,
                        thickness: 3,
                        color: Constant.lightColorScheme.primaryContainer,
                      ),
                    ),
                    const Divider(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.2,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              source.toString(),
                              softWrap: true,
                              maxLines: 4,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 14,
                                color:
                                    Constant.lightColorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
          SizedBox(
            width: 100,
            child: status == 'Yet to Start'
                ? ElevatedButton(
                    onPressed: () => onPressed != null
                        ? onPressed!()
                        : Navigator.pop(context),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Constant.lightColorScheme.inversePrimary),
                    ),
                    child: Text(
                      btnText!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Constant.lightColorScheme.onPrimaryContainer,
                      ),
                    ),
                  )
                : ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                    ),
                    child: FittedBox(
                      child: Text(
                        'Completed',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Constant.lightColorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

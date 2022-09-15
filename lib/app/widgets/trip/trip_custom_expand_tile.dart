import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../screens/trip/trip_controller.dart';
import '../../utils/constant.dart';
import '../global_custom/nav_route_widget.dart';

class TripCustomExpandTile extends StatelessWidget {
  final String? index;
  const TripCustomExpandTile({Key? key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyTripController myTripController =
        FlutterCleanArchitecture.getController<MyTripController>(context);
    return Card(
      child: ExpansionTile(
          // initiallyExpanded: true,
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
                  children: [
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Text(
                        'John Client',
                        style: TextStyle(
                            color: Constant.lightColorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
                Text(
                  '47km',
                  style: TextStyle(
                    color: Constant.lightColorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: NavRouteWidget(
                onPressed: () => myTripController.navigate(),
                btnText: 'Navigate',
                destination:
                    'Panabo City Seawall and Park, 1, Bunawan, Panabo, Davao del Norte',
                source: 'Corrales Avenue, Cagayan de Oro, Misamis Oriental',
              ),
            ),
          ]),
    );
  }
}

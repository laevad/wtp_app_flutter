import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../domain/entities/trip.dart';
import '../../screens/trip/trip_controller.dart';
import '../../utils/constant.dart';
import '../global_custom/custom_text_softwrap.dart';
import '../global_custom/nav_route_widget.dart';

class TripCustomExpandTile extends StatelessWidget {
  final String? index;
  final Trip? trip;

  const TripCustomExpandTile({Key? key, this.index, this.trip})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TripController myTripController =
        FlutterCleanArchitecture.getController<TripController>(context);
    return Card(
      child: ExpansionTile(
          // initiallyExpanded: true,
          title: Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              color:
                  Constant.lightColorScheme.primaryContainer.withOpacity(0.3),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor:
                          Constant.lightColorScheme.onPrimaryContainer,
                      child: Text(index.toString()),
                    ),
                    CustomTextWrap(text: trip!.client!),
                  ],
                ),
                Text(
                  "${trip!.totalDistance!}km",
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
                onPressed: () => myTripController.navigate(
                  destination: trip!.tripEnd!,
                  source: trip!.tripStart!,
                  fromLatitude: trip!.fromLatitude,
                  fromLongitude: trip!.fromLongitude,
                  toLatitude: trip!.toLatitude,
                  toLongitude: trip!.toLongitude,
                ),
                btnText: 'Navigate',
                destination: trip!.tripStart!,
                source: trip!.tripEnd!,
              ),
            ),
          ]),
    );
  }
}

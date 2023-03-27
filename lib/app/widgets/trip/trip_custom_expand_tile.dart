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
            color: Constant.lightColorScheme.primaryContainer.withOpacity(0.3),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  children: [
                    Text(
                      '${trip!.id?.split("-")[0]}' + '  ',
                      style: TextStyle(
                        fontSize: 14,
                        color: Constant.lightColorScheme.onSurfaceVariant,
                      ),
                      softWrap: true,
                    ),
                    Column(
                      children: [
                        trip!.tripStatus == 'Completed'
                            ? Text(
                                trip!.dateCompleted!,
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 14,
                                  color: Constant
                                      .lightColorScheme.onSurfaceVariant,
                                ),
                                softWrap: true,
                              )
                            : Text(
                                trip!.startDate! + ' - ' + trip!.endDate!,
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 14,
                                  color: Constant
                                      .lightColorScheme.onSurfaceVariant,
                                ),
                                softWrap: true,
                              ),
                        Text(
                          trip!.tripStatus!,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 14,
                            color: Constant.lightColorScheme.onSurfaceVariant,
                          ),
                          softWrap: true,
                        ),
                      ],
                    ),
                    Container(
                      child: Text('  '),
                    ),
                    // CustomTextWrap(text: trip!.tripStatus!),
                  ],
                ),
              ),
              Text(
                "${trip!.totalDistance!.toStringAsFixed(2)}km",
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
                bookingId: trip!.id,
                destination: trip!.tripEnd!,
                source: trip!.tripStart!,
                fromLatitude: trip!.fromLatitude,
                fromLongitude: trip!.fromLongitude,
                toLatitude: trip!.toLatitude,
                toLongitude: trip!.toLongitude,
                status: trip!.tripStatus,
              ),
              id: trip!.id,
              status: trip!.tripStatus,
              btnText: 'Start Navigate',
              destination: trip!.tripStart!,
              source: trip!.tripEnd!,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../data/repository/trip/data_trip_repository.dart';
import '../../utils/constant.dart';
import '../../widgets/trip/trip_custom_expand_tile.dart';
import 'trip_controller.dart';

class TripView extends View {
  static String routeName = '/my-trip';
  const TripView({Key? key}) : super(key: key);

  @override
  TripViewState createState() => TripViewState();
}

class TripViewState extends ViewState<TripView, TripController> {
  TripViewState() : super(TripController(DataTripRepository()));

  @override
  Widget get view {
    return ControlledWidgetBuilder<TripController>(
      builder: (context, controller) {
        if (controller.trip == null) {
          return Container();
        }
        return Theme(
          data: Constant.themeData,
          child: DefaultTabController(
            length: 2,
            child: SafeArea(
              child: Scaffold(
                key: globalKey,
                body: Column(
                  children: [
                    TabBar(
                      indicatorColor: Constant.lightColorScheme.primary,
                      tabs: [
                        Tab(
                          icon: Icon(
                            Icons.car_rental,
                            color: Constant.lightColorScheme.primary,
                          ),
                        ),
                        Tab(
                          icon: Icon(
                            Icons.history,
                            color: Constant.lightColorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 1),
                          child: RefreshIndicator(
                            onRefresh: controller.refresh,
                            child: ListView.builder(
                              itemCount: controller.trip!.length,
                              controller: controller.scrollController,
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return TripCustomExpandTile(
                                  index: (index + 1).toString(),
                                  trip: controller.trip![index],
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 1),
                          child: ListView.builder(
                            itemCount: 1,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return Container();
                            },
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

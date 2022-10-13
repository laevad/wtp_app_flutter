import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtp_app/data/repository/incentive/data_incentive_repository.dart';

import '../../utils/constant.dart';
import '../../widgets/incentive/custom_expand_tile_incentive.dart';
import 'incentives_controller.dart';

class IncentivesView extends View {
  static String routeName = '/history';
  const IncentivesView({Key? key}) : super(key: key);

  @override
  State<IncentivesView> createState() => IncentivesViewState();
}

class IncentivesViewState
    extends ViewState<IncentivesView, IncentivesController> {
  IncentivesViewState()
      : super(IncentivesController(
          DataIncentiveRepository(),
        ));

  @override
  Widget get view {
    return ControlledWidgetBuilder<IncentivesController>(
      builder: (context, controller) {
        if (controller.incentive == null) {
          return Container();
        }
        return Theme(
          data: ThemeData(
              colorScheme: Constant.lightColorScheme,
              textTheme: GoogleFonts.openSansTextTheme().apply(
                  displayColor: const Color(0xFF383838),
                  bodyColor: const Color(0xFF383838)),
              useMaterial3: true),
          child: Scaffold(
            key: globalKey,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Constant.lightColorScheme.primaryContainer,
              centerTitle: true,
              title: const Text(
                'Incentives',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1),
                      child: ListView.builder(
                        controller: controller.scrollController,
                        itemCount: controller.incentive!.length,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return CustomExpandTileIncentive(
                            index: (index + 1).toString(),
                            incentive: controller.incentive![index],
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    width: double.infinity,
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Total : ${controller.amount}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

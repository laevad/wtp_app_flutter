import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constant.dart';
import '../../widgets/history/history_custom_expand_tile.dart';
import 'incentives_controller.dart';

class IncentivesView extends View {
  static String routeName = '/history';
  const IncentivesView({Key? key}) : super(key: key);

  @override
  State<IncentivesView> createState() => IncentivesViewState();
}

class IncentivesViewState
    extends ViewState<IncentivesView, IncentivesController> {
  IncentivesViewState() : super(IncentivesController());

  @override
  Widget get view {
    return ControlledWidgetBuilder<IncentivesController>(
      builder: (context, controller) {
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
              backgroundColor: Constant.lightColorScheme.primaryContainer,
              title: Text(
                controller.dateString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () => controller.selectDate(),
                  icon: const Icon(Icons.date_range),
                ),
              ],
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
                        itemCount: 1,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return HistoryCustomExpandTile(
                              index: (index + 1).toString());
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    width: double.infinity,
                    child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Total : 2000',
                          style: TextStyle(
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

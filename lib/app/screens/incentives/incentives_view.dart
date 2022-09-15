import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constant.dart';
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
  Widget get view => ControlledWidgetBuilder<IncentivesController>(
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
            ),
          );
        },
      );
}

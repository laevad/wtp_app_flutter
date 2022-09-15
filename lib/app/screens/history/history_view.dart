import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtp_app/app/widgets/history/history_custom_expand_tile.dart';

import '../../utils/constant.dart';
import 'history_controller.dart';

class HistoryView extends View {
  static String routeName = '/history';
  const HistoryView({Key? key}) : super(key: key);

  @override
  State<HistoryView> createState() => HistoryViewState();
}

class HistoryViewState extends ViewState<HistoryView, HistoryController> {
  HistoryViewState() : super(HistoryController());

  @override
  Widget get view => ControlledWidgetBuilder<HistoryController>(
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
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  child: ListView.builder(
                    itemCount: 12,
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
            ),
          );
        },
      );
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constant.dart';
import '../global_custom/nav_route_widget.dart';

class NavigateView extends StatefulWidget {
  String? destination;
  String? source;
  NavigateView({Key? key, this.destination, this.source}) : super(key: key);

  @override
  State<NavigateView> createState() => _NavigateViewState();
}

class _NavigateViewState extends State<NavigateView> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          colorScheme: Constant.lightColorScheme,
          textTheme: GoogleFonts.openSansTextTheme().apply(
              displayColor: const Color(0xFF383838),
              bodyColor: const Color(0xFF383838)),
          useMaterial3: true),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.7,
              child: Container(
                color: Colors.red,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 3.9,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                child: NavRouteWidget(
                    btnText: 'Finish',
                    destination: widget.destination,
                    source: widget.source),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

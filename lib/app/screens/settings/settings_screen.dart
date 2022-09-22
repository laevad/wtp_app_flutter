import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constant.dart';
import '../../widgets/profile/button_tile_widget.dart';
import 'settings_controller.dart';

class SettingsScreen extends View {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends ViewState<SettingsScreen, SettingsController> {
  ProfileScreenState() : super(SettingsController());

  @override
  Widget get view {
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
          title: Row(
            children: const [
              SizedBox(
                width: 8,
              ),
              Text(
                'Account',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: ControlledWidgetBuilder<SettingsController>(
              builder: (context, controller) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      ButtonTileWidget(
                        iconData: Icons.person,
                        context: context,
                        title: 'Profile',
                        onTap: () => controller.editProfile(),
                      ),
                      ButtonTileWidget(
                        iconData: Icons.exit_to_app,
                        context: context,
                        title: 'Logout',
                        onTap: () => controller.logout(),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

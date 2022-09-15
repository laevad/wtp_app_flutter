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
        body: SafeArea(
          child: ControlledWidgetBuilder<SettingsController>(
              builder: (context, controller) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.person,
                              color: Color(0xFFFB578E),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Account',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          height: 15,
                          thickness: 2,
                        ),
                        ButtonTileWidget(
                          context: context,
                          title: 'Profile',
                          onTap: () => controller.editProfile(),
                        ),
                        ButtonTileWidget(
                          context: context,
                          title: 'Logout',
                          onTap: () => controller.logout(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

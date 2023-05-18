import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart' as clean_architecture;

import '../../utils/constant.dart';
import '../../widgets/profile/button_tile_widget.dart';
import 'settings_controller.dart';

class SettingsScreen extends clean_architecture.View {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends clean_architecture.ViewState<SettingsScreen, SettingsController> {
  ProfileScreenState() : super(SettingsController());

  @override
  Widget get view {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Constant.lightColorScheme.primaryContainer,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SizedBox(
              width: 8,
            ),
            Text(
              'Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: clean_architecture.ControlledWidgetBuilder<SettingsController>(
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
                      iconData: Icons.cloud_sync_outlined,
                      context: context,
                      title: 'Server Url',
                      onTap: () => controller.editServerUrl(),
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
    );
  }
}

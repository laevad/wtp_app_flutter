import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constant.dart';
import '../../widgets/profile/button_tile_widget.dart';
import 'profile_controller.dart';

class ProfileScreen extends View {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends ViewState<ProfileScreen, ProfileController> {
  ProfileScreenState() : super(ProfileController());

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
        appBar: AppBar(
          elevation: 1,
          centerTitle: true,
          title: const Text(
            'Settings',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        key: globalKey,
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: ControlledWidgetBuilder<ProfileController>(
                builder: (context, controller) {
              return Column(
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
              );
            }),
          ),
        ),
      ),
    );
  }
}

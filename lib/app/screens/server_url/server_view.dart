import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'server_controller.dart';

import '../../utils/constant.dart';
import '../../widgets/edit_profile/edit_custom_input.dart';
import '../../widgets/global_custom/custom_button_save_changes.dart';

class ServerView extends View {
  static String routeName = '/server-url';
  const ServerView({Key? key}) : super(key: key);

  @override
  ServerViewState createState() => ServerViewState();
}

class ServerViewState extends ViewState<ServerView, ServerController> {
  ServerViewState() : super(ServerController());

  @override
  Widget get view => ControlledWidgetBuilder<ServerController>(
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
                title: Text(
                  'Edit Server Url',
                  style: TextStyle(
                    color: Constant.lightColorScheme.onSurfaceVariant,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: Colors.black.withOpacity(0.7),
                ),
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 1,
              ),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                child: Column(
                  children: [
                    EditCustomInput(
                      controller: controller.urlController,
                      labelText: 'Server',
                      hintText: 'e.g http://192.168.88.27:8000/api',
                    ),
                    const SizedBox(height: 25),
                    CustomButtonSaveChanges(
                      onPressed: () => controller.save(),
                      text: 'Save Changes',
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
}

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart' as clean_architecture;

import '../../utils/constant.dart';
import '../../widgets/edit_profile/edit_custom_input.dart';
import '../../widgets/global_custom/custom_button_save_changes.dart';
import 'server_controller.dart';

class ServerView extends clean_architecture.View {
  static String routeName = '/server-url';
  const ServerView({Key? key}) : super(key: key);

  @override
  ServerViewState createState() => ServerViewState();
}

class ServerViewState extends clean_architecture.ViewState<ServerView, ServerController> {
  ServerViewState() : super(ServerController());

  @override
  Widget get view => clean_architecture.ControlledWidgetBuilder<ServerController>(
        builder: (context, controller) {
          return Scaffold(
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
          );
        },
      );
}

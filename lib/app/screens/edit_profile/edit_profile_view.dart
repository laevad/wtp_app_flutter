import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'edit_profile_controller.dart';

class EditProfileView extends View {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  EditProfileViewState createState() => EditProfileViewState();
}

class EditProfileViewState
    extends ViewState<EditProfileView, EditProfileController> {
  EditProfileViewState() : super(EditProfileController());

  @override
  Widget get view {
    return ControlledWidgetBuilder(
      builder: (context, controller) {
        return Scaffold(
          key: globalKey,
        );
      },
    );
  }
}

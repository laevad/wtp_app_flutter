import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wtp_app/app/utils/constant.dart';
import 'package:wtp_app/app/widgets/edit_profile/edit_custom_input.dart';

import 'edit_profile_controller.dart';

class EditProfileView extends View {
  static String routeName = "/editProfile";
  const EditProfileView({Key? key}) : super(key: key);

  @override
  EditProfileViewState createState() => EditProfileViewState();
}

class EditProfileViewState
    extends ViewState<EditProfileView, EditProfileController> {
  EditProfileViewState() : super(EditProfileController());

  @override
  Widget get view {
    return ControlledWidgetBuilder<EditProfileController>(
      builder: (context, controller) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            key: globalKey,
            appBar: AppBar(
              title: Text(
                'Edit Profile',
                style: TextStyle(
                  color: Constant.lightColorScheme.onSurfaceVariant,
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
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Center(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: const Offset(0, 10),
                                ),
                              ],
                              shape: BoxShape.circle,
                              image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  "https://images.pexels.com/photos/220453/"
                                  "pexels-photo-220453.jpeg?auto=compress&"
                                  "cs=tinysrgb&w=1260&h=750&dpr=1",
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 4,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                shape: BoxShape.circle,
                                color: Constant.lightColorScheme.primary,
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      EditCustomInput(
                        labelText: 'Name',
                        hintText: 'John Doe',
                      ),
                      const SizedBox(height: 20),
                      EditCustomInput(
                        labelText: 'Email',
                        hintText: 'johndoe@example.com',
                      ),
                      const SizedBox(height: 20),
                      EditCustomInput(
                        labelText: 'Mobile Number',
                        hintText: '+639',
                      ),
                      const SizedBox(height: 20),
                      EditCustomInput(
                        labelText: 'Age',
                        hintText: '20',
                      ),
                      const SizedBox(height: 20),
                      EditCustomInput(
                        showPass: true,
                        labelText: 'Password',
                        isPass: true,
                      ),
                      const SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Constant.lightColorScheme.primary,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          child: Text(
                            'SAVE',
                            style: TextStyle(fontSize: 14, letterSpacing: 2.2),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart' as clean_architecture;

import '../../../data/repository/auth/data_auth_token_repository.dart';
import '../../utils/constant.dart';
import '../../widgets/global_custom/custom_textfield.dart';
import '../../widgets/login/login_custom_btn.dart';
import 'login_controller.dart';

class LoginScreen extends clean_architecture.View {
  static String routeName = '/login-screen';
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends clean_architecture.ViewState<LoginScreen, LoginController> {
  LoginScreenState() : super(LoginController(DataAuthRepository()));

  @override
  Widget get view => clean_architecture.ControlledWidgetBuilder<LoginController>(
        builder: (context, controller) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                actions: [
                  IconButton(
                      onPressed: () => controller.serverUrlSettings(),
                      icon: const Icon(Icons.settings)),
                ],
              ),
              key: globalKey,
              body: SafeArea(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(
                    parent: NeverScrollableScrollPhysics(),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Form(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Welcome,',
                                      style: TextStyle(
                                        fontSize: 34,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    FittedBox(
                                      child: Text(
                                        'WT&P Management System | Sign In',
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w600,
                                          color: Constant
                                              .lightColorScheme.tertiary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              CustomTextField(
                                labelText: 'Email',
                                controller: controller.emailController,
                                errorMsg: controller.getAuthToken?.emailMsg,
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              CustomTextField(
                                labelText: 'Password',
                                isObscure: true,
                                controller: controller.passwordController,
                                errorMsg:
                                    controller.getAuthToken?.passwordMsg,
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              LoginCustomBtn(
                                onPressed: controller.login,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
}

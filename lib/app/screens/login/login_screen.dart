import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_fonts/google_fonts.dart';

import '/app/utils/constant.dart';
import '../../../data/repository/auth/data_auth_token_repository.dart';
import 'login_controller.dart';

class LoginScreen extends View {
  static String routeName = '/login-screen';
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ViewState<LoginScreen, LoginController> {
  LoginScreenState() : super(LoginController(DataAuthRepository()));

  @override
  Widget get view => ControlledWidgetBuilder<LoginController>(
        builder: (context, controller) {
          return Theme(
            data: ThemeData(
                colorScheme: Constant.lightColorScheme,
                textTheme: GoogleFonts.openSansTextTheme().apply(
                    displayColor: const Color(0xFF383838),
                    bodyColor: const Color(0xFF383838)),
                useMaterial3: true),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Scaffold(
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
                                      MediaQuery.of(context).size.height / 4,
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
                                TextFormField(
                                  validator: (val) {
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(14),
                                      ),
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 20,
                                      horizontal: 20,
                                    ),
                                    labelText: 'Username',
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                TextFormField(
                                  validator: (val) {
                                    return null;
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(14),
                                      ),
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 20,
                                      horizontal: 20,
                                    ),
                                    labelText: 'Password',
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Container(
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      stops: [
                                        0.20,
                                        0.90,
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Color(0xFFFB578E),
                                        Color(0xFFFDA58E),
                                      ],
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14)),
                                  ),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 20,
                                        horizontal: 20,
                                      ),
                                    ),
                                    onPressed: () async {
                                      // Navigator.pushNamedAndRemoveUntil(
                                      //     context,
                                      //     BottomNavView.routeName,
                                      //     (Route<dynamic> route) => false);
                                      controller.login(
                                          email: "a@a.a", pass: "1234");
                                    },
                                    child: const Text(
                                      'Sign In',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () async {},
                                  child: const Text("is auth"),
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
            ),
          );
        },
      );
}

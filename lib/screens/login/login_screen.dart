import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../home/home_screen.dart';
import '../../constant.dart';



class LoginScreen extends StatelessWidget {
  static String routeName = '/login-screen';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          colorScheme: Constant.lightColorScheme,
          textTheme: GoogleFonts.openSansTextTheme().apply(
              displayColor: const Color(0xFF383838),
              bodyColor: const Color(0xFF383838)),
          useMaterial3: true),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(
                parent: NeverScrollableScrollPhysics()),
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
                        // Text('WT&P Management System',style: TextStyle(fontWeight: FontWeight.w600,color: Constant.lightColorScheme.primary,  fontSize: 20,),),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Welcome,',
                                style: TextStyle(
                                    fontSize: 34, fontWeight: FontWeight.w600),
                              ),
                              FittedBox(
                                child: Text(
                                  'WT&P Management System | Sign In',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600,
                                      color: Constant.lightColorScheme.tertiary),
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
                              borderRadius:
                              const BorderRadius.all(Radius.circular(14)),
                              borderSide: BorderSide(
                                  color:
                                  Theme.of(context).colorScheme.tertiary),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
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
                              borderRadius:
                              const BorderRadius.all(Radius.circular(14)),
                              borderSide: BorderSide(
                                  color:
                                  Theme.of(context).colorScheme.tertiary),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
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
                            borderRadius: BorderRadius.all(Radius.circular(14)),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                            ),
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, HomeScreen.routeName, (Route<dynamic> route) => false);
                            },
                            child: const Text('Sign In', style: TextStyle(color: Colors.white),),
                          ),
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
  }
}

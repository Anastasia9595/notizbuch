import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notizapp/presentation/components/sign_button.dart';
import 'package:notizapp/presentation/components/textfield.dart';
import 'package:notizapp/presentation/view/pages/login.dart';
import 'package:notizapp/presentation/view/screens/responsive_screens/mobile_screen.dart';

import '../../../business_logic/cubits/theme_cubit/theme_cubit.dart';
import '../../../business_logic/helpers/constants.dart';
import '../../../main.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({super.key, required this.onClickedSignUp});
  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final VoidCallback onClickedSignUp;

  Future signUp(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      UserCredential result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailTextController.text,
        password: _passwordTextController.text,
      );
      User? user = result.user;
      if (user != null) {
        await user.updateDisplayName(_nameTextController.text);
      }
    } on FirebaseAuthException catch (e) {
      log(e.toString());
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state.switchValue;
    return Scaffold(
      backgroundColor: themeState ? kBackgroundColorLight : kBackgroundColorDark,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // greeting
                Text(
                  'Hello',
                  style: TextStyle(
                    color: themeState ? Colors.black : Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Create Account',
                  style: TextStyle(
                    color: themeState ? Colors.black : Colors.white,
                    fontSize: 26,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextfieldComponent(
                  textEditingController: _nameTextController,
                  hintext: 'Name',
                  obscureText: false,
                  icon: const Icon(Icons.person),
                ),
                const SizedBox(
                  height: 20,
                ),
                // email textfield
                TextfieldComponent(
                  textEditingController: _emailTextController,
                  hintext: 'Email',
                  obscureText: false,
                  icon: Icon(Icons.mail),
                ),
                const SizedBox(
                  height: 20,
                ),

                // password textfield
                TextfieldComponent(
                  textEditingController: _passwordTextController,
                  hintext: 'Password',
                  obscureText: true,
                  icon: Icon(Icons.security),
                ),
                const SizedBox(
                  height: 25,
                ),

                //sign in button
                SignButton(
                  onPressedFunction: () => signUp(context),
                  buttonName: 'Sign up',
                ),

                const SizedBox(
                  height: 25,
                ),

                // register button
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: 'Sign in',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            onClickedSignUp();
                          },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),

                const Text(
                  'Or Sign up with',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                SizedBox(
                  height: 15,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/google.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/github.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/facebook.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

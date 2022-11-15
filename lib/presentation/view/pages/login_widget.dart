import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:notizapp/business_logic/helpers/constants.dart';
import 'package:notizapp/main.dart';

import '../../components/sign_button.dart';
import '../../components/textfield.dart';
import '../../../business_logic/helpers/utils.dart';

class LoginWidget extends StatelessWidget {
  LoginWidget({super.key, required this.onClickedSignUp, required this.onClickedForgotPassword});
  final formKey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final VoidCallback onClickedSignUp;
  final VoidCallback onClickedForgotPassword;
  bool isValid = false;

  Future signIn(BuildContext context) async {
    isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailTextController.text,
        password: _passwordTextController.text,
      );
    } on FirebaseAuthException catch (e) {
      Utils.showSnackbar('${e.message}');
      log(e.toString());
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                // greeting
                const Text(
                  'Hello Again',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Welcome Back',
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 26,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                // email textfield
                TextfieldComponent(
                  validator: (email) => Utils.validateEmail(email),
                  autovalidateMode: isValid ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                  textEditingController: _emailTextController,
                  hintext: 'Email',
                  obscureText: false,
                  icon: const Icon(
                    Icons.mail,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                // password textfield
                TextfieldComponent(
                  validator: (password) => Utils.validatePassword(password),
                  autovalidateMode: isValid ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                  textEditingController: _passwordTextController,
                  hintext: 'Password',
                  obscureText: true,
                  icon: const Icon(
                    Icons.security,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: TextButton(
                          onPressed: onClickedForgotPassword,
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(color: kTextButtonColor),
                          )),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 18,
                ),

                // register button
                SignButton(
                  onPressedFunction: () => signIn(context),
                  buttonName: 'Sign in',
                ),
                const SizedBox(
                  height: 20,
                ),

                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Don\'t have an account? ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: 'Sign up',
                        style: const TextStyle(
                          color: kTextButtonColor,
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
                  'Or Sign in with',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                const SizedBox(
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
                            image: AssetImage('assets/facebook.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        height: 35,
                        width: 35,
                        child: SvgPicture.asset('assets/github.svg'),
                      ),
                    ),
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

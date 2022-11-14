import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notizapp/main.dart';
import 'package:notizapp/presentation/components/utils.dart';

import '../../components/sign_button.dart';
import '../../components/textfield.dart';
import 'forgotpassword_page.dart';

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
      Utils.showSnackbar('No user found for that email.');
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
                  autovalidateMode: isValid ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                  validator: (email) => email != null && !EmailValidator.validate(email) ? 'Enter a valid email' : null,
                  textEditingController: _emailTextController,
                  hintext: 'Email',
                  obscureText: false,
                  icon: const Icon(Icons.mail),
                ),
                const SizedBox(
                  height: 20,
                ),

                // password textfield
                TextfieldComponent(
                  autovalidateMode: isValid ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                  validator: (password) => password != null && password.length < 6 ? 'Enter min. 6 characters' : null,
                  textEditingController: _passwordTextController,
                  hintext: 'Password',
                  obscureText: true,
                  icon: const Icon(Icons.security),
                ),
                const SizedBox(
                  height: 25,
                ),

                //sign in button

                const SizedBox(
                  height: 20,
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
                          color: Colors.blue,
                          fontSize: 16,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            onClickedSignUp();
                          },
                      ),
                      const TextSpan(
                        text: ' \nor ',
                        style: TextStyle(
                          height: 1.5,
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: '\nForgot Password?',
                        style: const TextStyle(
                          height: 1.5,
                          color: Colors.blue,
                          fontSize: 16,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            onClickedForgotPassword();
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

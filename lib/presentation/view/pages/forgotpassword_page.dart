import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:notizapp/presentation/components/utils.dart';

import '../../components/sign_button.dart';
import '../../components/textfield.dart';

class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({super.key, required this.onClickedSignIn});
  final formKey = GlobalKey<FormState>();
  // final VoidCallback onClickedSignUp;
  bool isValid = false;
  final _emailTextController = TextEditingController();
  final VoidCallback onClickedSignIn;

  Future resetPassword(BuildContext context) async {
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
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailTextController.text.trim());
      Utils.showSnackbar('Password reset email sent.');
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      Utils.showSnackbar('No user found for that email.');
      Navigator.of(context).pop();
      log(e.toString());
    }
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
                  'Reset Password',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                  ),
                ),
                const SizedBox(
                  height: 10,
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

                //sign in button

                const SizedBox(
                  height: 20,
                ),

                // register button
                SignButton(
                  onPressedFunction: () => resetPassword(context),
                  buttonName: 'Reset Password ✉',
                ),
                const SizedBox(
                  height: 20,
                ),

                const SizedBox(
                  height: 15,
                ),

                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Already have an account?',
                        style: TextStyle(
                          height: 1.5,
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: '\nSign In',
                        style: const TextStyle(
                          height: 1.5,
                          color: Colors.blue,
                          fontSize: 16,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = onClickedSignIn,
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

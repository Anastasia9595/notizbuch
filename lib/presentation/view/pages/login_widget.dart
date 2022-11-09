import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:notizapp/main.dart';
import 'package:notizapp/presentation/view/pages/registration.dart';

import '../../components/sign_button.dart';
import '../../components/textfield.dart';

class LoginWidget extends StatelessWidget {
  LoginWidget({super.key, required this.onClickedSignUp});
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final VoidCallback onClickedSignUp;

  Future signIn(BuildContext context) async {
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
    );
  }
}

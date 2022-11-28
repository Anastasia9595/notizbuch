import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notizapp/business_logic/cubits/signup_cubit/signup_cubit.dart';

import 'package:notizapp/presentation/components/sign_button.dart';
import 'package:notizapp/presentation/components/textfield.dart';
import 'package:notizapp/business_logic/helpers/utils.dart';

import '../../../business_logic/cubits/obscure_cubit/obscure_cubit.dart';
import '../../../business_logic/cubits/theme_cubit/theme_cubit.dart';
import '../../../business_logic/helpers/constants.dart';
import '../../../main.dart';

class RegistrationWidget extends StatelessWidget {
  RegistrationWidget({super.key, required this.onClickedSignUp});

  final formKey = GlobalKey<FormState>();
  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final VoidCallback onClickedSignUp;
  bool isValid = false;

  void _signUpwitEmailandPassword(BuildContext context) {
    if (formKey.currentState!.validate()) {
      showDialog(
          context: context,
          builder: (context) => const Center(
                child: CircularProgressIndicator(),
              ));
      context.read<SignupCubit>().signUpWithCredentials(_emailTextController.text.trim(),
          _passwordTextController.text.trim(), _nameTextController.text.trim(), context);
      // Future.delayed(Duration(seconds: 2));
      // context.read<SignupCubit>().addUserToDatabase(_nameTextController.text.trim(), _emailTextController.text.trim());
    }
  }

  Future signUp(BuildContext context) async {
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
      //create User
      UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailTextController.text.trim(),
        password: _passwordTextController.text.trim(),
      );
      // add user details
      try {
        final docUser = FirebaseFirestore.instance.collection('users').doc(user.user!.uid);
        await docUser.set({
          'name': _nameTextController.text.trim(),
          'email': _emailTextController.text.trim(),
        });
      } catch (e) {
        log(e.toString());
      }
    } on FirebaseAuthException catch (e) {
      Utils.showSnackbar('User already exists');
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
            child: Form(
              key: formKey,
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
                    suffixIcon: null,
                    autovalidateMode: isValid ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                    validator: (name) => Utils.validateName(name),
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
                    suffixIcon: null,
                    autovalidateMode: isValid ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                    validator: (email) => Utils.validateEmail(email),
                    textEditingController: _emailTextController,
                    hintext: 'Email',
                    obscureText: false,
                    icon: const Icon(Icons.mail),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // password textfield
                  BlocBuilder<ObscureCubit, ObscureState>(
                    builder: (context, state) {
                      return TextfieldComponent(
                        suffixIcon: IconButton(
                          icon: Icon(
                            state.obscureText ? Icons.visibility_off : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            context.read<ObscureCubit>().toggleObscure();
                          },
                        ),
                        validator: (password) => Utils.validatePassword(password),
                        autovalidateMode: isValid ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                        textEditingController: _passwordTextController,
                        hintext: 'Password',
                        obscureText: state.obscureText,
                        icon: const Icon(
                          Icons.security,
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),

                  //sign in button
                  SignButton(
                    onPressedFunction: () {
                      // _signUpwitEmailandPassword(context);
                      context.read<SignupCubit>().signUpWithCredentials(_emailTextController.text.trim(),
                          _passwordTextController.text.trim(), _nameTextController.text.trim(), context);
                      // context.read<SignupCubit>().addUserToDatabase(
                      //     _nameTextController.text.trim(), _emailTextController.text.trim(), context);
                    },
                    buttonName: 'Sign up',
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  // register button
                  RichText(
                    textAlign: TextAlign.center,
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
                          text: '\nSign in',
                          style: const TextStyle(
                            color: kTextButtonColor,
                            fontSize: 16,
                            height: 1.8,
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
                        child: SizedBox(
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
      ),
    );
  }
}

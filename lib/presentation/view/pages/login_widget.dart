// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';

import 'package:notizapp/business_logic/cubits/login_cubit/login_cubit.dart';
import 'package:notizapp/business_logic/cubits/obscure_cubit/obscure_cubit.dart';
import 'package:notizapp/business_logic/helpers/constants.dart';
import 'package:notizapp/presentation/view/screens/responsive_screens/mobile_screen.dart';

import '../../../business_logic/helpers/utils.dart';
import '../../../main.dart';
import '../../components/sign_button.dart';
import '../../components/textfield.dart';

class LoginWidget extends StatelessWidget {
  LoginWidget({
    Key? key,
    required this.onClickedSignUp,
    required this.onClickedForgotPassword,
  }) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final VoidCallback onClickedSignUp;
  final VoidCallback onClickedForgotPassword;
  bool isValid = false;

  void _signInWithEmailAndPassword(BuildContext context) {
    if (formKey.currentState!.validate()) {
      showDialog(
          context: context,
          builder: (context) => const Center(
                child: CircularProgressIndicator(),
              ));
      context
          .read<LoginCubit>()
          .logInWithCredentials(_emailTextController.text.trim(), _passwordTextController.text.trim());
    }
  }

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

  void login(BuildContext context) async {
    try {
      Response response = await post(Uri.parse('http://10.0.2.2:8000/api/login'), body: {
        'email': _emailTextController.text.trim(),
        'password': _passwordTextController.text.trim(),
      });

      if (response.statusCode == 201) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MobileScreen(),
        ));
      } else {
        log('failed');
      }
    } catch (e) {
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
                  suffixIcon: null,
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
                  onPressedFunction: () => login(context),
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
    );
  }
}

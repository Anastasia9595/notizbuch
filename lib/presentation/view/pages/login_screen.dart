import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notizapp/business_logic/cubits/login_cubit/login_cubit.dart';
import 'package:notizapp/business_logic/cubits/login_cubit/login_state.dart';
import 'package:notizapp/business_logic/cubits/signup_cubit/signup_cubit.dart';
import 'package:notizapp/business_logic/helpers/constants.dart';
import 'package:notizapp/presentation/view/pages/authentication.dart';
import 'package:notizapp/presentation/view/screens/responsive_screens/mobile_screen.dart';

import '../../../business_logic/cubits/signup_cubit/signup_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static Page page() => const MaterialPage<void>(child: LoginScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColorDark,
      body: BlocBuilder<SignupCubit, SignupState>(
        builder: (context, signupstate) {
          return BlocListener<LoginCubit, LoginState>(
            listener: (context, signinstate) {
              if (signinstate.status == LoginStatus.sucess || signupstate.status == SignupStatus.success) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => MobileScreen(),
                  ),
                );
              } else if (signinstate.status == LoginStatus.signedOut || signupstate.status == SignupStatus.signOut) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              } else if (signinstate.status == LoginStatus.error) {
                log('Error');
              }
            },
            child: BlocBuilder<SignupCubit, SignupState>(
              builder: (context, signupstate) {
                return BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, signinstate) {
                    if (signinstate.status == LoginStatus.sucess || signupstate.status == SignupStatus.success) {
                      return MobileScreen();
                    }
                    return const Authentication();
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

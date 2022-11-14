import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notizapp/presentation/view/pages/authentication.dart';
import 'package:notizapp/presentation/view/pages/login_widget.dart';
import 'package:notizapp/presentation/view/pages/registration.dart';
import 'package:notizapp/presentation/view/screens/responsive_screens/mobile_screen.dart';

import '../../../business_logic/cubits/theme_cubit/theme_cubit.dart';
import '../../../business_logic/helpers/constants.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state.switchValue;
    return Scaffold(
      backgroundColor: themeState ? kBackgroundColorLight : kBackgroundColorDark,
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong!'),
              );
            } else if (snapshot.hasData) {
              return const MobileScreen();
            } else {
              return Authentication();
            }
          }),
    );
  }
}

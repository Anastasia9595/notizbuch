import 'package:flutter/material.dart';
import 'package:notizapp/presentation/view/pages/forgotpassword_page.dart';
import 'package:notizapp/presentation/view/pages/registration_widget.dart';

import 'login_widget.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool isLogin = true;
  bool forgotPassword = false;
  @override
  Widget build(BuildContext context) {
    if (forgotPassword) {
      return ResetPasswordPage(onClickedSignIn: toggleForgotPassword);
    } else {
      return isLogin
          ? LoginWidget(onClickedSignUp: toggle, onClickedForgotPassword: toggleForgotPassword)
          : RegistrationWidget(onClickedSignUp: toggle);
    }
  }

  void toggle() => setState(() => isLogin = !isLogin);
  void toggleForgotPassword() => setState(() => forgotPassword = !forgotPassword);
}

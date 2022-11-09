import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notizapp/presentation/view/pages/registration.dart';

import 'login_widget.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) => isLogin
      ? LoginWidget(
          onClickedSignUp: toggle,
        )
      : RegistrationPage(
          onClickedSignUp: toggle,
        );

  void toggle() => setState(() => isLogin = !isLogin);
}

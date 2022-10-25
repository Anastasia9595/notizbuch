import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notizapp/view/screens/responsive_layout.dart';
import 'package:notizapp/view/screens/responsive_screens/desktop_screen.dart';
import 'package:notizapp/view/screens/responsive_screens/mobile_screen.dart';
import 'package:notizapp/view/screens/responsive_screens/tablet_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScaffold: MobileScreen(),
            tabletScaffold: TabletScreen(),
            desktopScaffold: DesktopScreen(),
          ),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Stack(
        children: [],
      ),
    );
  }
}

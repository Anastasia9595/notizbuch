// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    Key? key,
    required this.mobileScaffold,
    required this.tabletScaffold,
    required this.desktopScaffold,
  }) : super(key: key);
  final Widget mobileScaffold;
  final Widget tabletScaffold;
  final Widget desktopScaffold;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 600) {
        return mobileScaffold;
      } else if (constraints.maxWidth < 1200) {
        return tabletScaffold;
      } else {
        return desktopScaffold;
      }
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notizapp/animation/searchbar.dart';
import 'package:notizapp/animation/switch.dart';
import 'package:notizapp/cubit/theme_cubit/theme_cubit.dart';

import '../view/pages/trash.dart';

class NavigationDrawer extends StatefulWidget {
  NavigationDrawer({Key? key, required this.showButton}) : super(key: key);

  bool showButton = true;
  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    return Drawer(
      backgroundColor: themeState.switchValue ? const Color(0xFFA88C7E) : const Color(0xff372E29),
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          widget.showButton
              ? DrawerHeader(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              : const Padding(
                  padding: EdgeInsets.only(left: 10, right: 20, top: 20),
                  child: SearchBar(),
                ),
          buildMenuItmes(context)
        ],
      )),
    );
  }

  buildMenuItmes(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: widget.showButton ? 0 : 80, left: 20),
      child: SafeArea(
        child: Wrap(
          runSpacing: 30,
          children: [
            ListTile(
              leading: const Icon(
                Icons.delete_forever,
                color: Colors.white,
              ),
              title: const Text(
                'Trash',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Trash()),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
              title: const Text(
                'Settings',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.help,
                color: Colors.white,
              ),
              title: const Text(
                'Help',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onTap: () {},
            ),
            BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                return ListTile(
                    leading: Icon(
                      state.switchValue ? Icons.dark_mode : Icons.wb_sunny,
                      color: Colors.white,
                    ),
                    title: Text(
                      state.switchValue ? 'Dark Mode' : 'Light Mode',
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    trailing: const SwitchAnimation());
              },
            ),
          ],
        ),
      ),
    );
  }
}

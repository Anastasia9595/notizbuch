import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notizapp/animation/switch.dart';
import 'package:notizapp/cubit/theme_cubit/theme_cubit.dart';
import 'package:notizapp/view/archive.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({super.key});

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
        children: [buildMenuItmes(context)],
      )),
    );
  }

  buildMenuItmes(BuildContext context) {
    return SafeArea(
      child: Wrap(
        runSpacing: 16,
        children: [
          ListTile(
            leading: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            leading: const Icon(
              Icons.storage_rounded,
              color: Colors.white,
            ),
            title: const Text(
              'Archive',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Archive()),
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
    );
  }
}

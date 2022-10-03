import 'package:flutter/material.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({super.key});

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  bool light = true;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFA88C7E),
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
            onTap: () {},
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
          ListTile(
            leading: const Icon(
              Icons.dark_mode,
              color: Colors.white,
            ),
            title: const Text(
              'Dark Mode',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            trailing: Switch(
                value: light,
                activeColor: Colors.amber,
                onChanged: (value) {
                  setState(() {
                    light = value;
                  });
                }),
          ),
        ],
      ),
    );
  }
}

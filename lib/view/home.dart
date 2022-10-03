import 'package:flutter/material.dart';
import 'package:notizapp/components/notecard.dart';

import '../components/navigationdrawer.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.cloud_upload,
              size: 30,
            ),
          )
        ],
      ),
      drawer: const NavigationDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text(
            'Alle Notizen (5)',
            style: TextStyle(fontSize: 30),
          ),
          NoteCard()
        ],
      ),
    );
  }
}

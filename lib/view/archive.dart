import 'package:flutter/material.dart';
import 'package:notizapp/components/notecard.dart';
import 'package:notizapp/view/home.dart';

class Archive extends StatelessWidget {
  const Archive({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Homepage(),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 30,
          ),
        ),
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
        ],
      ),
      body: Column(
        children: const [
          Text(
            'Archive',
            style: TextStyle(fontSize: 30),
          ),
        ],
      ),
    );
  }
}

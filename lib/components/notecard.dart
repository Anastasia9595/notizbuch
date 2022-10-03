import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key});

  //
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 12),
      child: Card(
        child: ListTile(),
      ),
    );
  }
}

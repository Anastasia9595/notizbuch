// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class DismissibleCard extends StatelessWidget {
  const DismissibleCard({
    Key? key,
    required this.swipe,
    required this.children,
    this.dir,
  }) : super(key: key);

  /// Function that gets executed if widget is dragged to the left
  final Function swipe;

  /// Children of the widget
  final List<Widget> children;

  /// Change direction
  final DismissDirection? dir;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: buildSwipeLeftAction(),
      secondaryBackground: buildSwipeRightAction(),
      key: key!,
      //direction: isDragging ? DismissDirection.horizontal : DismissDirection.endToStart,
      confirmDismiss: (dir) => Future.delayed(
        const Duration(milliseconds: 100),
        () {
          return swipe();
        },
      ),
      child: Column(children: children),
    );
  }

  Widget buildSwipeLeftAction() => Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 32,
        ),
      );
  Widget buildSwipeRightAction() => Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 32,
        ),
      );
}

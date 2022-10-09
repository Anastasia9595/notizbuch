import 'package:flutter/material.dart';

class Alert extends StatelessWidget {
  const Alert({
    required this.onPressed,
    required this.title,
    required this.description,
    Key? key,
  }) : super(key: key);

  final Function onPressed;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('CANCEL'),
        ),
        TextButton(
          onPressed: () => onPressed(),
          child: const Text('CONFIRM'),
        )
      ],
    );
  }
}

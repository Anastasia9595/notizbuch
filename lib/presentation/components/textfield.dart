import 'package:flutter/material.dart';

class TextfieldComponent extends StatelessWidget {
  const TextfieldComponent(
      {super.key,
      required this.hintext,
      required this.obscureText,
      required this.icon,
      required this.textEditingController});
  final String hintext;
  final bool obscureText;
  final Icon icon;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: TextField(
            controller: textEditingController,
            obscureText: obscureText,
            decoration: InputDecoration(border: InputBorder.none, hintText: hintext, icon: icon),
          ),
        ),
      ),
    );
  }
}

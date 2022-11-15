import 'package:flutter/material.dart';

class TextfieldComponent extends StatelessWidget {
  const TextfieldComponent({
    super.key,
    required this.autovalidateMode,
    required this.hintext,
    required this.obscureText,
    required this.icon,
    required this.textEditingController,
    required this.validator,
  });
  final String hintext;
  final AutovalidateMode autovalidateMode;
  final bool obscureText;
  final Icon icon;
  final TextEditingController textEditingController;
  final String? Function(String?)? validator;

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
          child: TextFormField(
            validator: validator,
            controller: textEditingController,
            autovalidateMode: autovalidateMode,
            obscureText: obscureText,
            decoration: InputDecoration(border: InputBorder.none, hintText: hintext, icon: icon),
          ),
        ),
      ),
    );
  }
}

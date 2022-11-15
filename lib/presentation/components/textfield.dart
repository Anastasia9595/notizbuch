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
    this.showErrorMessage = false,
    required this.suffixIcon,
  });
  final String hintext;
  final AutovalidateMode autovalidateMode;
  final bool obscureText;
  final Icon icon;
  final TextEditingController textEditingController;
  final String? Function(String?)? validator;
  final bool showErrorMessage;
  final IconButton? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: TextFormField(
              validator: validator,
              controller: textEditingController,
              autovalidateMode: autovalidateMode,
              obscureText: obscureText,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                fillColor: Colors.white,
                filled: true,
                hintText: hintext,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                prefixIcon: icon,
                suffixIcon: suffixIcon,
              ),
            ),
          ),
          if (showErrorMessage)
            const Padding(
              padding: EdgeInsets.only(left: 10, top: 4),
              child: Text(
                'Error',
                style: TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
    );
  }
}

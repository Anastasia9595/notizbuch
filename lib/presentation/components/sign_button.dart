import 'package:flutter/material.dart';

class SignButton extends StatelessWidget {
  const SignButton({super.key, required this.onPressedFunction, required this.buttonName});
  final Function onPressedFunction;
  final String buttonName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: TextButton(
              onPressed: () => onPressedFunction(),
              child: Text(
                buttonName,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              )),
        ),
      ),
    );
  }
}

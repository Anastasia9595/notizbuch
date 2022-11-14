import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required this.validator,
    required this.errorText,
    required this.autovlaidate,
  });
  final String? Function(String?)? validator;
  final bool autovlaidate;
  final String errorText;

  @override
  Widget build(BuildContext context) {
    return FormField(
        validator: validator,
        builder: (state) {
          state.validate();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              state.errorText != null
                  ? Text(
                      errorText,
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    )
                  : Container(),
            ],
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:news/constants.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
    this.controller, {
    Key? key,
    required this.hint,
    this.validator,
    this.keyboardType,
  }) : super(key: key);

  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        fillColor: white,
        filled: true,
        border: border(),
        errorBorder: border(color: red),
        enabledBorder: border(),
        focusedBorder: border(),
        disabledBorder: border(),
        focusedErrorBorder: border(color: red),
      ),
    );
  }

  OutlineInputBorder border({Color? color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.5),
      borderSide: BorderSide(color: color ?? trans, width: double.minPositive),
    );
  }
}

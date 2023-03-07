import 'package:flutter/material.dart';

class TextFormInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const TextFormInput(
      {super.key,
      required this.label,
      required this.controller,
      // required
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        fillColor: Colors.grey.shade200,
        filled: true,
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.grey.shade700,
        ),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide.none),
      ),
      controller: controller,
      validator: validator,
    );
  }
}

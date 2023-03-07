import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget body;

  final ButtonStyle btnStyle = ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0)),
      backgroundColor: MaterialStateProperty.all<Color>(Colors.green.shade300),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))));

  FormButton({super.key, required this.onPressed, required this.body});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: btnStyle,
      child: body,
    );
  }
}

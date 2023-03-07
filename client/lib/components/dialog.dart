import 'package:flutter/material.dart';
import 'package:todo/components/button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey.shade200,
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Button(
                    text: "Salvar",
                    onPressed: onSave,
                    btnColor: Colors.green.shade300),
                const SizedBox(
                  width: 8,
                ),
                Button(
                  text: "Cancelar",
                  onPressed: onCancel,
                  btnColor: Colors.red.shade300,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

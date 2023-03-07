import 'package:flutter/material.dart';

import '../components/text_form_input.dart';

class GenerateInputs extends StatelessWidget {
  // final List<String> labels;
  final List<String> labels;
  final List<TextEditingController> controllers;

  const GenerateInputs(
      {super.key, required this.labels, required this.controllers});

  Widget genInputs(
      List<String> labels, List<TextEditingController> controllers) {
    // + https://fireship.io/snippets/dart-how-to-get-the-index-on-array-loop-map/
    return Column(
      children: labels
          .asMap()
          .entries
          .map((entry) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: TextFormInput(
                label: entry.value,
                controller: controllers[entry.key],
              )))
          .toList(),
    );

    // ! com erros
    // List<Widget> widgets = [];
    // strings.forEach((label, controller) => widgets.add(
    //       Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    //           child: FormInput(
    //             label: label,
    //             controller: controller,
    //           )),
    //     ));
  }

  @override
  Widget build(BuildContext context) {
    return genInputs(labels, controllers);
  }
}

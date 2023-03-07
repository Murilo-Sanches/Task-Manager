import 'package:flutter/material.dart';

class ColumnCenter extends StatelessWidget {
  final List<Widget> childrens;

  const ColumnCenter({super.key, required this.childrens});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: childrens,
    );
  }
}

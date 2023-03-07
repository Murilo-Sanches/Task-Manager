import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toast extends StatelessWidget {
  final String body;

  const Toast({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Fluttertoast.showToast(
        msg: body,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      ),
    );
  }
}

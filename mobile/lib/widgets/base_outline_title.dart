import 'package:flutter/material.dart';

class BaseOutlineButtonTitle extends StatelessWidget {
  final String text;
  final Color color;

  BaseOutlineButtonTitle(this.text, {@required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(text.toUpperCase(),
        style: TextStyle(
            fontWeight: FontWeight.bold, color: color));
  }
}
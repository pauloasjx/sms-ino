import 'package:flutter/material.dart';

class BaseCard extends StatelessWidget {
  @required
  final Widget child;
  final bool visible;
  final Color color;
  final Function onTap;

  BaseCard(
      {this.child, this.visible = true, this.color = Colors.white, this.onTap});

  @override
  Widget build(BuildContext context) {
    return visible
        ? InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                spreadRadius: 0.5,
                blurRadius: 4,
                offset: Offset(1, 1),
              ),
            ]),
        child: child,
      ),
    )
        : Container(child: child);
  }
}
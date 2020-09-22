import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {

  Function onTap;
  Widget icon;
  Color color;
  bool halfOpacity;

  BaseButton({this.onTap, this.icon, this.color, this.halfOpacity=false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Opacity(
        opacity: halfOpacity ? 0.33 : 1.0,
        child: Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(64.0),
                color: color,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 0.5,
                    blurRadius: 4,
                    offset: Offset(1, 1),
                  ),
                ]),
            child: icon),
      ),
    );
  }
}

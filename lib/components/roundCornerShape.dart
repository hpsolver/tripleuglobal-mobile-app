import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

class RoundCornerShape extends StatelessWidget {
  Widget child;
  Color bgColor;
  Color strokeColor;
  double radius;

  RoundCornerShape(
      {required this.child, required this.bgColor, required this.radius,this.strokeColor=Colors.transparent});

  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = new ScreenScaler()
      ..init(context);
    return Container(
        child: Material(
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: strokeColor
              ),
              borderRadius: scaler.getBorderRadiusCircularLR(
                  radius, radius, radius, radius)),
          color: bgColor,
          child: child,
        ));
  }
}

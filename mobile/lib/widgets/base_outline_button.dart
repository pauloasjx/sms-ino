import 'package:flutter/material.dart';

class BaseOutlineButton extends StatelessWidget {
  final _GradientPainter painter;
  final Widget child;
  final VoidCallback callback;
  final EdgeInsets margin;
  final double radius;

  BaseOutlineButton(
      {double strokeWidth,
        double radius,
        Gradient gradient,
        Widget child,
        VoidCallback onPressed,
        EdgeInsets margin})
      : this.painter = _GradientPainter(
      strokeWidth: strokeWidth ?? 2.0,
      radius: radius ?? 6.0,
      gradient: gradient ??
          LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.red[700],
              Colors.red,
            ],
          )),
        this.child = child,
        this.callback = onPressed,
        this.radius = radius ?? 8.0,
        this.margin = margin ?? EdgeInsets.all(0);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: callback == null ? 0.5 : 1.0,
      child: Container(
        margin: margin,
        child: Container(
          decoration: BoxDecoration(
//            color: Colors.white,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: CustomPaint(
            painter: painter,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: callback,
              child: InkWell(
                borderRadius: BorderRadius.circular(radius),
                onTap: callback,
                child: Container(
                  constraints: BoxConstraints(minWidth: 88, minHeight: 48),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      child,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GradientPainter extends CustomPainter {
  final Paint _paint = Paint();
  final double radius;
  final double strokeWidth;
  final Gradient gradient;

  _GradientPainter({double strokeWidth, double radius, Gradient gradient})
      : this.strokeWidth = strokeWidth,
        this.radius = radius,
        this.gradient = gradient;

  @override
  void paint(Canvas canvas, Size size) {
    // create outer rectangle equals size
    Rect outerRect = Offset.zero & size;
    var outerRRect =
    RRect.fromRectAndRadius(outerRect, Radius.circular(radius));

    // create inner rectangle smaller by strokeWidth
    Rect innerRect = Rect.fromLTWH(strokeWidth, strokeWidth,
        size.width - strokeWidth * 2, size.height - strokeWidth * 2);
    var innerRRect = RRect.fromRectAndRadius(
        innerRect, Radius.circular(radius - strokeWidth));

    // apply gradient shader
    _paint.shader = gradient.createShader(outerRect);

    // create difference between outer and inner paths and draw it
    Path path1 = Path()..addRRect(outerRRect);
    Path path2 = Path()..addRRect(innerRRect);
    var path = Path.combine(PathOperation.difference, path1, path2);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}
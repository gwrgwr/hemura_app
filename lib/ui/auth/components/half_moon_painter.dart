import 'package:flutter/material.dart';

class HalfMoonPainter extends CustomPainter {

  final BuildContext context;

  HalfMoonPainter(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Theme.of(context).colorScheme.primary;

    Path path = Path();
    path.lineTo(0, size.height * 1);
    path.quadraticBezierTo(
      size.width / 2,
      size.height * 1.6,
      size.width,
      size.height * 1,
    );
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

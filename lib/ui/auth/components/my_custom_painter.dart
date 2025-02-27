import 'package:flutter/material.dart';
import 'package:hemura/ui/auth/components/half_moon_painter.dart';

class MyCustomPainter extends StatelessWidget {
  const MyCustomPainter({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: CustomPaint(
        size: Size(MediaQuery.of(context).size.width, 200),
        painter: HalfMoonPainter(context),
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Image(
            image: AssetImage("assets/fotoamor.png"),
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class WheelPainter extends CustomPainter {
  final List<bool> isOn;

  WheelPainter({required this.isOn});

  @override
  void paint(Canvas canvas, Size size) {
    final paintWheel = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = Colors.black;
    final paintPoint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = Colors.black;
    final List<Paint> paintsPointFillOff = [
      Paint()
        ..style = PaintingStyle.fill
        ..color = Colors.red.shade50,
      Paint()
        ..style = PaintingStyle.fill
        ..color = Colors.yellow.shade50,
      Paint()
        ..style = PaintingStyle.fill
        ..color = Colors.green.shade50,
      Paint()
        ..style = PaintingStyle.fill
        ..color = Colors.blue.shade50,
    ];
    final List<Paint> paintsPointFillOn = [
      Paint()
        ..style = PaintingStyle.fill
        ..color = Colors.red,
      Paint()
        ..style = PaintingStyle.fill
        ..color = Colors.yellow,
      Paint()
        ..style = PaintingStyle.fill
        ..color = Colors.green,
      Paint()
        ..style = PaintingStyle.fill
        ..color = Colors.blue,
    ];
    double radiusWheel = size.width / 2;
    Offset offsetWheel = Offset(radiusWheel, 0);
    double radiusPoint = radiusWheel / 3;

    print('here');
    print(size.width);

    canvas.drawCircle(offsetWheel, radiusWheel, paintWheel);
    for (int i = 0; i < 4; i++) {
      makePoint(
          canvas: canvas,
          offsetWheel: offsetWheel,
          radiusWheel: radiusWheel,
          radiusPoint: radiusPoint,
          paintPoint: paintPoint,
          paintPointFill:
              isOn[i] ? paintsPointFillOn[i] : paintsPointFillOff[i],
          phase: i);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  void makePoint({
    required Canvas canvas,
    required Offset offsetWheel,
    required double radiusWheel,
    required double radiusPoint,
    required Paint paintPoint,
    required Paint paintPointFill,
    required int phase,
  }) {
    late Offset offsetPoint;
    switch (phase) {
      case 0:
        offsetPoint = Offset(offsetWheel.dx, offsetWheel.dy - radiusWheel);
        break;
      case 1:
        offsetPoint = Offset(offsetWheel.dx + radiusWheel, offsetWheel.dy);
        break;
      case 2:
        offsetPoint = Offset(offsetWheel.dx, offsetWheel.dy + radiusWheel);
        break;
      case 3:
        offsetPoint = Offset(offsetWheel.dx - radiusWheel, offsetWheel.dy);
        break;
    }
    canvas.drawCircle(offsetPoint, radiusPoint, paintPoint);
    canvas.drawCircle(offsetPoint, radiusPoint, paintPointFill);
  }
}

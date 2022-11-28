import 'package:flutter/widgets.dart';

class ChestIconPainter extends CustomPainter {
  final Color color;

  ChestIconPainter({
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.8444444, size.height * 0.1111111);
    path_0.lineTo(size.width * 0.7166667, size.height * 0.1111111);
    path_0.lineTo(size.width * 0.2833333, size.height * 0.1111111);
    path_0.lineTo(size.width * 0.1555556, size.height * 0.1111111);
    path_0.lineTo(size.width * 0.1111111, size.height * 0.1555556);
    path_0.lineTo(size.width * 0.1111111, size.height * 0.8444444);
    path_0.lineTo(size.width * 0.1555556, size.height * 0.8888889);
    path_0.lineTo(size.width * 0.8444444, size.height * 0.8888889);
    path_0.lineTo(size.width * 0.8888889, size.height * 0.8444444);
    path_0.lineTo(size.width * 0.8888889, size.height * 0.1555556);
    path_0.lineTo(size.width * 0.8444444, size.height * 0.1111111);
    path_0.close();
    path_0.moveTo(size.width * 0.4111111, size.height * 0.3277778);
    path_0.lineTo(size.width * 0.5000000, size.height * 0.2388889);
    path_0.lineTo(size.width * 0.5888889, size.height * 0.3277778);
    path_0.lineTo(size.width * 0.5888889, size.height * 0.5000000);
    path_0.lineTo(size.width * 0.5000000, size.height * 0.5888889);
    path_0.lineTo(size.width * 0.4111111, size.height * 0.5000000);
    path_0.lineTo(size.width * 0.4111111, size.height * 0.3277778);
    path_0.close();
    path_0.moveTo(size.width * 0.8000000, size.height * 0.8000000);
    path_0.lineTo(size.width * 0.2000000, size.height * 0.8000000);
    path_0.lineTo(size.width * 0.2000000, size.height * 0.2000000);
    path_0.lineTo(size.width * 0.2888889, size.height * 0.2888889);
    path_0.lineTo(size.width * 0.2888889, size.height * 0.5500000);
    path_0.lineTo(size.width * 0.5000000, size.height * 0.7166667);
    path_0.lineTo(size.width * 0.7166667, size.height * 0.5444444);
    path_0.lineTo(size.width * 0.7166667, size.height * 0.2833333);
    path_0.lineTo(size.width * 0.8055556, size.height * 0.1944444);
    path_0.lineTo(size.width * 0.8055556, size.height * 0.8000000);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = color;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

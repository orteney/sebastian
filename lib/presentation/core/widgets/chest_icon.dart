import 'package:flutter/widgets.dart';

class ChestIconPainter extends CustomPainter {
  final Color color;

  ChestIconPainter({
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9428567, 0);
    path_0.lineTo(size.width * 0.7785700, 0);
    path_0.lineTo(size.width * 0.2214287, 0);
    path_0.lineTo(size.width * 0.05714300, 0);
    path_0.lineTo(0, size.height * 0.05714300);
    path_0.lineTo(0, size.height * 0.9428567);
    path_0.lineTo(size.width * 0.05714300, size.height);
    path_0.lineTo(size.width * 0.9428567, size.height);
    path_0.lineTo(size.width, size.height * 0.9428567);
    path_0.lineTo(size.width, size.height * 0.05714300);
    path_0.lineTo(size.width * 0.9428567, 0);
    path_0.close();
    path_0.moveTo(size.width * 0.3857133, size.height * 0.2785713);
    path_0.lineTo(size.width * 0.5000000, size.height * 0.1642857);
    path_0.lineTo(size.width * 0.6142867, size.height * 0.2785713);
    path_0.lineTo(size.width * 0.6142867, size.height * 0.5000000);
    path_0.lineTo(size.width * 0.5000000, size.height * 0.6142867);
    path_0.lineTo(size.width * 0.3857133, size.height * 0.5000000);
    path_0.lineTo(size.width * 0.3857133, size.height * 0.2785713);
    path_0.close();
    path_0.moveTo(size.width * 0.8857133, size.height * 0.8857133);
    path_0.lineTo(size.width * 0.1142857, size.height * 0.8857133);
    path_0.lineTo(size.width * 0.1142857, size.height * 0.1142857);
    path_0.lineTo(size.width * 0.2285713, size.height * 0.2285713);
    path_0.lineTo(size.width * 0.2285713, size.height * 0.5642867);
    path_0.lineTo(size.width * 0.5000000, size.height * 0.7785700);
    path_0.lineTo(size.width * 0.7785700, size.height * 0.5571433);
    path_0.lineTo(size.width * 0.7785700, size.height * 0.2214287);
    path_0.lineTo(size.width * 0.8928567, size.height * 0.1071430);
    path_0.lineTo(size.width * 0.8928567, size.height * 0.8857133);
    path_0.lineTo(size.width * 0.8857133, size.height * 0.8857133);
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

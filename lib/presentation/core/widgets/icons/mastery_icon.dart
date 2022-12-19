import 'package:flutter/widgets.dart';

class MasteryIcon extends StatelessWidget {
  const MasteryIcon({
    super.key,
    this.size = const Size(24, 24),
    this.color = const Color(0xFFCDBE91),
  });

  final Color color;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: size,
      painter: _MasteryIconPainter(
        color: color,
      ),
    );
  }
}

class _MasteryIconPainter extends CustomPainter {
  final Color color;

  _MasteryIconPainter({
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.7777792, size.height * 0.4642875);
    path_0.lineTo(size.width * 0.9444458, size.height * 0.4077387);
    path_0.lineTo(size.width * 0.9444458, size.height * 0.5208333);
    path_0.lineTo(size.width * 0.7777792, size.height * 0.6904750);
    path_0.lineTo(size.width * 0.8333333, size.height * 0.6904750);
    path_0.lineTo(size.width * 0.8333333, size.height * 0.7470250);
    path_0.lineTo(size.width * 0.7222208, size.height * 0.8035708);
    path_0.lineTo(size.width * 0.7222208, size.height * 0.2946433);
    path_0.lineTo(size.width, size.height * 0.1250000);
    path_0.lineTo(size.width, size.height * 0.2946433);
    path_0.lineTo(size.width * 0.7777792, size.height * 0.4642875);
    path_0.close();
    path_0.moveTo(size.width * 0.3888888, size.height * 0.8035708);
    path_0.lineTo(size.width * 0.3888888, size.height * 0.2380954);
    path_0.lineTo(size.width * 0.6111125, size.height * 0.2380954);
    path_0.lineTo(size.width * 0.6111125, size.height * 0.8035708);
    path_0.lineTo(size.width * 0.5000000, size.height * 0.9166667);
    path_0.lineTo(size.width * 0.3888888, size.height * 0.8035708);
    path_0.close();
    path_0.moveTo(size.width * 0.1666667, size.height * 0.6904750);
    path_0.lineTo(size.width * 0.2222221, size.height * 0.6904750);
    path_0.lineTo(size.width * 0.05555542, size.height * 0.5208333);
    path_0.lineTo(size.width * 0.05555542, size.height * 0.4077387);
    path_0.lineTo(size.width * 0.2222221, size.height * 0.4642875);
    path_0.lineTo(0, size.height * 0.2946433);
    path_0.lineTo(0, size.height * 0.1250000);
    path_0.lineTo(size.width * 0.2777779, size.height * 0.2946433);
    path_0.lineTo(size.width * 0.2777779, size.height * 0.8035708);
    path_0.lineTo(size.width * 0.1666667, size.height * 0.7470250);
    path_0.lineTo(size.width * 0.1666667, size.height * 0.6904750);
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

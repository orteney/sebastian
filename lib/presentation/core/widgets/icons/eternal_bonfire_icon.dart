import 'package:flutter/widgets.dart';

class EternalBonfireIcon extends StatelessWidget {
  const EternalBonfireIcon({
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
      painter: _EternalBonfirePainter(
        color: color,
      ),
    );
  }
}

class _EternalBonfirePainter extends CustomPainter {
  final Color color;

  _EternalBonfirePainter({
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.8304458, size.height * 0.5932292);
    path_0.lineTo(size.width * 0.7489208, size.height * 0.6780667);
    path_0.cubicTo(size.width * 0.7192750, size.height * 0.7088875, size.width * 0.6779292, size.height * 0.7264375,
        size.width * 0.6346292, size.height * 0.7264375);
    path_0.lineTo(size.width * 0.3925921, size.height * 0.7264375);
    path_0.cubicTo(size.width * 0.3680175, size.height * 0.7264375, size.width * 0.3438333, size.height * 0.7207792,
        size.width * 0.3217937, size.height * 0.7098625);
    path_0.cubicTo(size.width * 0.2664037, size.height * 0.6823625, size.width * 0.2238862, size.height * 0.6351625,
        size.width * 0.2030175, size.height * 0.5778208);
    path_0.lineTo(size.width * 0.1690812, size.height * 0.4845917);
    path_0.cubicTo(size.width * 0.1634250, size.height * 0.4689875, size.width * 0.1679108, size.height * 0.4516292,
        size.width * 0.1803933, size.height * 0.4405125);
    path_0.lineTo(size.width * 0.3282300, size.height * 0.3100354);
    path_0.lineTo(size.width * 0.2901983, size.height * 0.3829783);
    path_0.cubicTo(size.width * 0.2784963, size.height * 0.4052129, size.width * 0.2790813, size.height * 0.4317375,
        size.width * 0.2915633, size.height * 0.4537750);
    path_0.lineTo(size.width * 0.3149675, size.height * 0.4949292);
    path_0.cubicTo(size.width * 0.3214037, size.height * 0.5062417, size.width * 0.3373971, size.height * 0.5079958,
        size.width * 0.3461733, size.height * 0.4980500);
    path_0.lineTo(size.width * 0.4674833, size.height * 0.3617196);
    path_0.cubicTo(size.width * 0.4793833, size.height * 0.3484571, size.width * 0.4836750, size.height * 0.3301242,
        size.width * 0.4789917, size.height * 0.3129608);
    path_0.lineTo(size.width * 0.4323792, size.height * 0.1450354);
    path_0.lineTo(size.width * 0.5634417, size.height * 0.04166667);
    path_0.lineTo(size.width * 0.5234625, size.height * 0.1319679);
    path_0.cubicTo(size.width * 0.5164375, size.height * 0.1477658, size.width * 0.5191708, size.height * 0.1660992,
        size.width * 0.5302875, size.height * 0.1793617);
    path_0.lineTo(size.width * 0.7003583, size.height * 0.3800533);
    path_0.cubicTo(size.width * 0.7130333, size.height * 0.3950708, size.width * 0.7151792, size.height * 0.4163296,
        size.width * 0.7054292, size.height * 0.4332958);
    path_0.lineTo(size.width * 0.6634958, size.height * 0.5072167);
    path_0.cubicTo(size.width * 0.6566708, size.height * 0.5193083, size.width * 0.6666167, size.height * 0.5339375,
        size.width * 0.6806583, size.height * 0.5323750);
    path_0.lineTo(size.width * 0.7551625, size.height * 0.5239875);
    path_0.cubicTo(size.width * 0.7697875, size.height * 0.5224292, size.width * 0.7807125, size.height * 0.5101417,
        size.width * 0.7807125, size.height * 0.4957083);
    path_0.lineTo(size.width * 0.7807125, size.height * 0.4214000);
    path_0.lineTo(size.width * 0.8380500, size.height * 0.5495375);
    path_0.cubicTo(size.width * 0.8448833, size.height * 0.5643625, size.width * 0.8417583, size.height * 0.5815250,
        size.width * 0.8304458, size.height * 0.5932292);
    path_0.close();
    path_0.moveTo(size.width * 0.1723967, size.height * 0.6987417);
    path_0.cubicTo(size.width * 0.2582125, size.height * 1.045125, size.width * 0.7610125, size.height * 1.044537,
        size.width * 0.8458583, size.height * 0.6979625);
    path_0.lineTo(size.width * 0.8491708, size.height * 0.6848917);
    path_0.lineTo(size.width * 0.7695958, size.height * 0.7605667);
    path_0.cubicTo(size.width * 0.7381958, size.height * 0.7904042, size.width * 0.6960667, size.height * 0.8071792,
        size.width * 0.6521833, size.height * 0.8071792);
    path_0.lineTo(size.width * 0.3855708, size.height * 0.8071792);
    path_0.cubicTo(size.width * 0.3514396, size.height * 0.8071792, size.width * 0.3180883, size.height * 0.7970375,
        size.width * 0.2900033, size.height * 0.7781250);
    path_0.lineTo(size.width * 0.1723967, size.height * 0.6987417);
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

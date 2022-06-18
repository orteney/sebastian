import 'package:flutter/widgets.dart';

class MasteryTag extends StatelessWidget {
  const MasteryTag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(28, 38),
      painter: _MasteryTagCustomPainter(),
    );
  }
}

//Copy this CustomPainter code to the Bottom of the File
class _MasteryTagCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, 0);
    path_0.lineTo(0, 35);
    path_0.lineTo(15, 29);
    path_0.lineTo(30, 35);
    path_0.lineTo(30, 0);
    path_0.lineTo(0, 0);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0xff211A19).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);

    Path path_1 = Path();
    path_1.moveTo(21.1111, 15.3369);
    path_1.lineTo(24.7778, 14.1147);
    path_1.lineTo(24.7778, 16.5592);
    path_1.lineTo(21.1111, 20.2258);
    path_1.lineTo(22.3333, 20.2258);
    path_1.lineTo(22.3333, 21.448);
    path_1.lineTo(19.8889, 22.6702);
    path_1.lineTo(19.8889, 11.6703);
    path_1.lineTo(26, 8.0036);
    path_1.lineTo(26, 11.6703);
    path_1.lineTo(21.1111, 15.3369);
    path_1.close();
    path_1.moveTo(12.5556, 22.6702);
    path_1.lineTo(12.5556, 10.448);
    path_1.lineTo(17.4444, 10.448);
    path_1.lineTo(17.4444, 22.6702);
    path_1.lineTo(15, 25.1147);
    path_1.lineTo(12.5556, 22.6702);
    path_1.close();
    path_1.moveTo(7.66667, 20.2258);
    path_1.lineTo(8.88889, 20.2258);
    path_1.lineTo(5.22222, 16.5592);
    path_1.lineTo(5.22222, 14.1147);
    path_1.lineTo(8.88889, 15.3369);
    path_1.lineTo(4, 11.6703);
    path_1.lineTo(4, 8.0036);
    path_1.lineTo(10.1111, 11.6703);
    path_1.lineTo(10.1111, 22.6702);
    path_1.lineTo(7.66667, 21.448);
    path_1.lineTo(7.66667, 20.2258);
    path_1.close();

    Paint paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.color = const Color(0xffC9C9C9).withOpacity(1.0);
    canvas.drawPath(path_1, paint1Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

import 'package:flutter/widgets.dart';

class CollectionTag extends StatelessWidget {
  const CollectionTag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(28, 38),
      painter: _CollectionTagCustomPainter(),
    );
  }
}

//Copy this CustomPainter code to the Bottom of the File
class _CollectionTagCustomPainter extends CustomPainter {
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
    path_1.moveTo(12.4124, 9.00205);
    path_1.cubicTo(12.4124, 8.77555, 12.5021, 8.57311, 12.6537, 8.42078);
    path_1.cubicTo(12.8051, 8.27045, 13.0065, 8.17825, 13.2317, 8.17825);
    path_1.lineTo(16.8042, 8.17825);
    path_1.cubicTo(17.0295, 8.17825, 17.2308, 8.26845, 17.3823, 8.42078);
    path_1.cubicTo(17.5319, 8.57311, 17.6235, 8.77555, 17.6235, 9.00205);
    path_1.lineTo(17.6235, 9.64545);
    path_1.lineTo(18.9632, 9.64545);
    path_1.lineTo(18.9632, 9.00205);
    path_1.cubicTo(18.9632, 8.40474, 18.718, 7.85955, 18.3293, 7.4687);
    path_1.cubicTo(17.9385, 7.07785, 17.3963, 6.83331, 16.8022, 6.83331);
    path_1.lineTo(13.2317, 6.83331);
    path_1.cubicTo(12.6376, 6.83331, 12.0954, 7.07785, 11.7067, 7.4707);
    path_1.cubicTo(11.318, 7.86156, 11.0728, 8.40675, 11.0728, 9.00405);
    path_1.lineTo(11.0728, 9.64745);
    path_1.lineTo(12.4124, 9.64745);
    path_1.lineTo(12.4124, 9.00205);
    path_1.close();

    Paint paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.color = const Color(0xffC9C9C9).withOpacity(1.0);
    canvas.drawPath(path_1, paint1Fill);

    Path path_2 = Path();
    path_2.moveTo(16.9612, 19.3224);
    path_2.cubicTo(16.5825, 19.6182, 16.1124, 19.7794, 15.6268, 19.7794);
    path_2.lineTo(15.6151, 19.7794);
    path_2.lineTo(14.3856, 19.7737);
    path_2.cubicTo(13.904, 19.7718, 13.4378, 19.6106, 13.0629, 19.3167);
    path_2.lineTo(8.02441, 15.3797);
    path_2.lineTo(8.02441, 23.5836);
    path_2.cubicTo(8.02441, 24.6266, 8.89847, 25.48, 9.96677, 25.48);
    path_2.lineTo(20.0671, 25.48);
    path_2.cubicTo(21.1353, 25.48, 22.0094, 24.6266, 22.0094, 23.5836);
    path_2.lineTo(22.0094, 15.3797);
    path_2.lineTo(16.9612, 19.3224);
    path_2.close();

    Paint paint2Fill = Paint()..style = PaintingStyle.fill;
    paint2Fill.color = const Color(0xffC9C9C9).withOpacity(1.0);
    canvas.drawPath(path_2, paint2Fill);

    Path path_3 = Path();
    path_3.moveTo(22.0612, 10.3571);
    path_3.lineTo(7.97284, 10.3571);
    path_3.cubicTo(7.42263, 10.3571, 6.97607, 10.806, 6.97607, 11.3592);
    path_3.lineTo(6.97607, 12.0868);
    path_3.cubicTo(6.97607, 12.3915, 7.11363, 12.6801, 7.35086, 12.8685);
    path_3.lineTo(13.7601, 18.0237);
    path_3.cubicTo(13.9355, 18.1641, 14.1528, 18.2422, 14.3781, 18.2443);
    path_3.lineTo(15.64, 18.2503);
    path_3.lineTo(15.646, 18.2503);
    path_3.cubicTo(15.8732, 18.2503, 16.0926, 18.1721, 16.268, 18.0298);
    path_3.lineTo(22.6852, 12.8685);
    path_3.cubicTo(22.9224, 12.6781, 23.06, 12.3915, 23.06, 12.0868);
    path_3.lineTo(23.06, 11.3592);
    path_3.cubicTo(23.0579, 10.806, 22.6114, 10.3571, 22.0612, 10.3571);
    path_3.close();

    Paint paint3Fill = Paint()..style = PaintingStyle.fill;
    paint3Fill.color = const Color(0xffC9C9C9).withOpacity(1.0);
    canvas.drawPath(path_3, paint3Fill);

    Path path_4 = Path();
    path_4.moveTo(6.47063, 23.9261);
    path_4.lineTo(6.02735, 23.9261);
    path_4.cubicTo(5.41564, 23.9261, 4.91675, 23.2863, 4.91675, 22.5063);
    path_4.lineTo(4.91675, 18.1189);
    path_4.lineTo(6.45157, 16.1567);
    path_4.lineTo(6.47063, 23.9261);
    path_4.close();

    Paint paint4Fill = Paint()..style = PaintingStyle.fill;
    paint4Fill.color = const Color(0xffC9C9C9).withOpacity(1.0);
    canvas.drawPath(path_4, paint4Fill);

    Path path_5 = Path();
    path_5.moveTo(23.5635, 23.9261);
    path_5.lineTo(24.0068, 23.9261);
    path_5.cubicTo(24.6169, 23.9261, 25.1173, 23.2883, 25.1173, 22.5063);
    path_5.lineTo(25.1173, 18.1189);
    path_5.lineTo(23.5825, 16.1567);
    path_5.lineTo(23.5635, 23.9261);
    path_5.close();

    Paint paint5Fill = Paint()..style = PaintingStyle.fill;
    paint5Fill.color = const Color(0xffC9C9C9).withOpacity(1.0);
    canvas.drawPath(path_5, paint5Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

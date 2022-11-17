import 'package:flutter/widgets.dart';

//Copy this CustomPainter code to the Bottom of the File
class PositionTopPainter extends CustomPainter {
  const PositionTopPainter();

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.6176471, size.height * 0.4117647);
    path_0.lineTo(size.width * 0.4117647, size.height * 0.4117647);
    path_0.lineTo(size.width * 0.4117647, size.height * 0.6176471);
    path_0.lineTo(size.width * 0.6176471, size.height * 0.6176471);
    path_0.lineTo(size.width * 0.6176471, size.height * 0.4117647);
    path_0.close();
    path_0.moveTo(size.width * 0.7647059, size.height * 0.3235294);
    path_0.lineTo(size.width * 0.7647059, size.height * 0.7647059);
    path_0.lineTo(size.width * 0.3239412, size.height * 0.7647059);
    path_0.lineTo(size.width * 0.2062941, size.height * 0.8823529);
    path_0.lineTo(size.width * 0.8823529, size.height * 0.8823529);
    path_0.lineTo(size.width * 0.8823529, size.height * 0.2063529);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0xff785a28).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.1176471, size.height * 0.1176471);
    path_1.lineTo(size.width * 0.1177353, size.height * 0.8248529);
    path_1.lineTo(size.width * 0.2647059, size.height * 0.6764706);
    path_1.lineTo(size.width * 0.2647059, size.height * 0.2647059);
    path_1.lineTo(size.width * 0.6764706, size.height * 0.2647059);
    path_1.lineTo(size.width * 0.8248529, size.height * 0.1177353);
    path_1.lineTo(size.width * 0.1176471, size.height * 0.1176471);
    path_1.close();

    Paint paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.color = const Color(0xffc8aa6e).withOpacity(1.0);
    canvas.drawPath(path_1, paint1Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PositionJunglePainter extends CustomPainter {
  const PositionJunglePainter();

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.7352941, size.height * 0.08823529);
    path_0.cubicTo(size.width * 0.6727059, size.height * 0.1852941, size.width * 0.5839118, size.height * 0.2897353,
        size.width * 0.5304118, size.height * 0.4255588);
    path_0.arcToPoint(Offset(size.width * 0.5882353, size.height * 0.5882353),
        radius: Radius.elliptical(size.width * 1.246265, size.height * 1.246265),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.arcToPoint(Offset(size.width * 0.6176471, size.height * 0.5000000),
        radius: Radius.elliptical(size.width * 0.8147059, size.height * 0.8147059),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.cubicTo(size.width * 0.6176471, size.height * 0.3536176, size.width * 0.6722353, size.height * 0.2434412,
        size.width * 0.7352941, size.height * 0.08823529);
    path_0.close();
    path_0.moveTo(size.width * 0.3823529, size.height * 0.5882353);
    path_0.cubicTo(size.width * 0.3385882, size.height * 0.4562647, size.width * 0.2423529, size.height * 0.3833529,
        size.width * 0.1176471, size.height * 0.3235294);
    path_0.cubicTo(size.width * 0.2314118, size.height * 0.4157647, size.width * 0.2477059, size.height * 0.5447059,
        size.width * 0.2647059, size.height * 0.6764706);
    path_0.lineTo(size.width * 0.3747941, size.height * 0.7738824);
    path_0.cubicTo(size.width * 0.4180882, size.height * 0.8210882, size.width * 0.4860882, size.height * 0.8956176,
        size.width * 0.5000000, size.height * 0.9117647);
    path_0.cubicTo(size.width * 0.6339706, size.height * 0.6339706, size.width * 0.4010000, size.height * 0.3000000,
        size.width * 0.2647059, size.height * 0.08823529);
    path_0.cubicTo(size.width * 0.3432353, size.height * 0.2815588, size.width * 0.4034412, size.height * 0.3924118,
        size.width * 0.3823529, size.height * 0.5882353);
    path_0.close();
    path_0.moveTo(size.width * 0.6176471, size.height * 0.7352941);
    path_0.arcToPoint(Offset(size.width * 0.6176471, size.height * 0.7941176),
        radius: Radius.elliptical(size.width * 0.4491471, size.height * 0.4491471),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.lineTo(size.width * 0.7352941, size.height * 0.6764706);
    path_0.cubicTo(size.width * 0.7522941, size.height * 0.5447059, size.width * 0.7685882, size.height * 0.4157647,
        size.width * 0.8823529, size.height * 0.3235294);
    path_0.cubicTo(size.width * 0.7268235, size.height * 0.3981471, size.width * 0.6510000, size.height * 0.5545294,
        size.width * 0.6176471, size.height * 0.7352941);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0xffc8aa6e).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PositionMidPainter extends CustomPainter {
  const PositionMidPainter();

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.8823529, size.height * 0.3814118);
    path_0.lineTo(size.width * 0.7644706, size.height * 0.4990588);
    path_0.lineTo(size.width * 0.7647059, size.height * 0.7647059);
    path_0.lineTo(size.width * 0.5000000, size.height * 0.7647059);
    path_0.lineTo(size.width * 0.3823529, size.height * 0.8823529);
    path_0.lineTo(size.width * 0.8823529, size.height * 0.8823529);
    path_0.close();
    path_0.moveTo(size.width * 0.4993824, size.height * 0.2352941);
    path_0.lineTo(size.width * 0.6176471, size.height * 0.1176471);
    path_0.lineTo(size.width * 0.1176471, size.height * 0.1176471);
    path_0.lineTo(size.width * 0.1176471, size.height * 0.6169706);
    path_0.lineTo(size.width * 0.2352941, size.height * 0.5000000);
    path_0.lineTo(size.width * 0.2352941, size.height * 0.2352941);
    path_0.lineTo(size.width * 0.4994412, size.height * 0.2352941);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0xff785a28).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.7352941, size.height * 0.1176471);
    path_1.lineTo(size.width * 0.1176471, size.height * 0.7352941);
    path_1.lineTo(size.width * 0.1176471, size.height * 0.8823529);
    path_1.lineTo(size.width * 0.2647059, size.height * 0.8823529);
    path_1.lineTo(size.width * 0.8823529, size.height * 0.2647059);
    path_1.lineTo(size.width * 0.8823529, size.height * 0.1176471);
    path_1.lineTo(size.width * 0.7352941, size.height * 0.1176471);
    path_1.close();

    Paint paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.color = const Color(0xffc8aa6e).withOpacity(1.0);
    canvas.drawPath(path_1, paint1Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PositionSupportPainter extends CustomPainter {
  const PositionSupportPainter();

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.7647059, size.height * 0.3823529);
    path_0.cubicTo(size.width * 0.8686765, size.height * 0.3823529, size.width, size.height * 0.2647059, size.width,
        size.height * 0.2647059);
    path_0.lineTo(size.width * 0.6764706, size.height * 0.2647059);
    path_0.lineTo(size.width * 0.5882353, size.height * 0.3529412);
    path_0.lineTo(size.width * 0.6470588, size.height * 0.5588235);
    path_0.lineTo(size.width * 0.7941176, size.height * 0.5000000);
    path_0.lineTo(size.width * 0.7058824, size.height * 0.3823529);
    path_0.lineTo(size.width * 0.7647059, size.height * 0.3823529);
    path_0.close();
    path_0.moveTo(size.width * 0.6470588, size.height * 0.1470588);
    path_0.lineTo(size.width * 0.6125588, size.height * 0.08823529);
    path_0.lineTo(size.width * 0.3841765, size.height * 0.08823529);
    path_0.lineTo(size.width * 0.3529412, size.height * 0.1470588);
    path_0.lineTo(size.width * 0.5000000, size.height * 0.3235294);
    path_0.close();
    path_0.moveTo(size.width * 0.5000000, size.height * 0.4117647);
    path_0.lineTo(size.width * 0.4705882, size.height * 0.3823529);
    path_0.lineTo(size.width * 0.3823529, size.height * 0.8235294);
    path_0.lineTo(size.width * 0.5000000, size.height * 0.9117647);
    path_0.lineTo(size.width * 0.6176471, size.height * 0.8235294);
    path_0.lineTo(size.width * 0.5294118, size.height * 0.3823529);
    path_0.close();
    path_0.moveTo(size.width * 0.3235294, size.height * 0.2647059);
    path_0.lineTo(0, size.height * 0.2647059);
    path_0.cubicTo(0, size.height * 0.2647059, size.width * 0.1313235, size.height * 0.3823529, size.width * 0.2352941,
        size.height * 0.3823529);
    path_0.lineTo(size.width * 0.2941176, size.height * 0.3823529);
    path_0.lineTo(size.width * 0.2058824, size.height * 0.5000000);
    path_0.lineTo(size.width * 0.3529412, size.height * 0.5588235);
    path_0.lineTo(size.width * 0.4117647, size.height * 0.3529412);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0xffc8aa6e).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PositionBotPainter extends CustomPainter {
  const PositionBotPainter();

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.3823529, size.height * 0.5882353);
    path_0.lineTo(size.width * 0.5882353, size.height * 0.5882353);
    path_0.lineTo(size.width * 0.5882353, size.height * 0.3823529);
    path_0.lineTo(size.width * 0.3823529, size.height * 0.3823529);
    path_0.lineTo(size.width * 0.3823529, size.height * 0.5882353);
    path_0.close();
    path_0.moveTo(size.width * 0.1176471, size.height * 0.1176471);
    path_0.lineTo(size.width * 0.1176471, size.height * 0.7936471);
    path_0.lineTo(size.width * 0.2339706, size.height * 0.6760000);
    path_0.lineTo(size.width * 0.2352941, size.height * 0.2352941);
    path_0.lineTo(size.width * 0.6760588, size.height * 0.2352941);
    path_0.lineTo(size.width * 0.7937059, size.height * 0.1176471);
    path_0.lineTo(size.width * 0.1176471, size.height * 0.1176471);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0xff785a28).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.8822647, size.height * 0.1751471);
    path_1.lineTo(size.width * 0.7352941, size.height * 0.3235294);
    path_1.lineTo(size.width * 0.7352941, size.height * 0.7352941);
    path_1.lineTo(size.width * 0.3235294, size.height * 0.7352941);
    path_1.lineTo(size.width * 0.1751471, size.height * 0.8822647);
    path_1.lineTo(size.width * 0.8823529, size.height * 0.8823529);
    path_1.lineTo(size.width * 0.8822647, size.height * 0.1751471);
    path_1.close();

    Paint paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.color = const Color(0xffc8aa6e).withOpacity(1.0);
    canvas.drawPath(path_1, paint1Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

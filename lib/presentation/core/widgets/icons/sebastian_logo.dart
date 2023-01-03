import 'dart:math';

import 'package:flutter/widgets.dart';

class SebastianLogo extends StatelessWidget {
  const SebastianLogo({
    this.size = const Size(100, 100),
    this.flip = false,
    super.key,
  });

  final Size size;
  final bool flip;

  @override
  Widget build(BuildContext context) {
    final logo = CustomPaint(
      size: size,
      painter: _SebastianLogoPainter(),
    );

    if (flip) {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: logo,
      );
    }

    return logo;
  }
}

class _SebastianLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.4480060, size.height * 0.1200000);
    path_0.cubicTo(size.width * 0.4632540, size.height * 0.1200000, size.width * 0.4845210, size.height * 0.1205400,
        size.width * 0.4954880, size.height * 0.1212140);
    path_0.cubicTo(size.width * 0.5063220, size.height * 0.1220240, size.width * 0.5211690, size.height * 0.1232380,
        size.width * 0.5285250, size.height * 0.1240470);
    path_0.cubicTo(size.width * 0.5358810, size.height * 0.1248570, size.width * 0.5479190, size.height * 0.1263410,
        size.width * 0.5552750, size.height * 0.1274200);
    path_0.cubicTo(size.width * 0.5626320, size.height * 0.1285000, size.width * 0.5719940, size.height * 0.1298490,
        size.width * 0.5760070, size.height * 0.1305230);
    path_0.cubicTo(size.width * 0.5800190, size.height * 0.1313330, size.width * 0.5855030, size.height * 0.1322770,
        size.width * 0.5880440, size.height * 0.1326820);
    path_0.cubicTo(size.width * 0.5905860, size.height * 0.1330870, size.width * 0.5951330, size.height * 0.1340310,
        size.width * 0.5980760, size.height * 0.1347060);
    path_0.cubicTo(size.width * 0.6010180, size.height * 0.1353800, size.width * 0.6061010, size.height * 0.1364600,
        size.width * 0.6094450, size.height * 0.1372690);
    path_0.cubicTo(size.width * 0.6127890, size.height * 0.1379440, size.width * 0.6209470, size.height * 0.1399680,
        size.width * 0.6275010, size.height * 0.1414520);
    path_0.cubicTo(size.width * 0.6341890, size.height * 0.1430710, size.width * 0.6410100, size.height * 0.1448250,
        size.width * 0.6428830, size.height * 0.1454990);
    path_0.cubicTo(size.width * 0.6447550, size.height * 0.1460390, size.width * 0.6489010, size.height * 0.1472530,
        size.width * 0.6522450, size.height * 0.1481980);
    path_0.cubicTo(size.width * 0.6555890, size.height * 0.1491420, size.width * 0.6609390, size.height * 0.1507610,
        size.width * 0.6642830, size.height * 0.1518400);
    path_0.cubicTo(size.width * 0.6676270, size.height * 0.1529200, size.width * 0.6721740, size.height * 0.1549430,
        size.width * 0.6743140, size.height * 0.1562920);
    path_0.cubicTo(size.width * 0.6765880, size.height * 0.1576420, size.width * 0.6795310, size.height * 0.1610150,
        size.width * 0.6808680, size.height * 0.1638480);
    path_0.cubicTo(size.width * 0.6823390, size.height * 0.1668160, size.width * 0.6838110, size.height * 0.1720780,
        size.width * 0.6840780, size.height * 0.1758550);
    path_0.cubicTo(size.width * 0.6844800, size.height * 0.1800380, size.width * 0.6836770, size.height * 0.1871880,
        size.width * 0.6819380, size.height * 0.1947440);
    path_0.cubicTo(size.width * 0.6803330, size.height * 0.2013550, size.width * 0.6775240, size.height * 0.2107990,
        size.width * 0.6755180, size.height * 0.2156560);
    path_0.cubicTo(size.width * 0.6736460, size.height * 0.2205130, size.width * 0.6708370, size.height * 0.2271240,
        size.width * 0.6693660, size.height * 0.2304960);
    path_0.cubicTo(size.width * 0.6678940, size.height * 0.2338690, size.width * 0.6618750, size.height * 0.2462820,
        size.width * 0.6561240, size.height * 0.2581540);
    path_0.cubicTo(size.width * 0.6502390, size.height * 0.2700270, size.width * 0.6435510, size.height * 0.2833840,
        size.width * 0.6411440, size.height * 0.2878360);
    path_0.cubicTo(size.width * 0.6386030, size.height * 0.2922880, size.width * 0.6335200, size.height * 0.3010580,
        size.width * 0.6296410, size.height * 0.3073990);
    path_0.cubicTo(size.width * 0.6257620, size.height * 0.3137400, size.width * 0.6188070, size.height * 0.3237240,
        size.width * 0.6141260, size.height * 0.3296600);
    path_0.cubicTo(size.width * 0.6095780, size.height * 0.3355960, size.width * 0.6027570, size.height * 0.3431520,
        size.width * 0.5991460, size.height * 0.3465250);
    path_0.cubicTo(size.width * 0.5955350, size.height * 0.3498970, size.width * 0.5912540, size.height * 0.3536750,
        size.width * 0.5896490, size.height * 0.3548890);
    path_0.cubicTo(size.width * 0.5880440, size.height * 0.3562390, size.width * 0.5832290, size.height * 0.3590720,
        size.width * 0.5790830, size.height * 0.3612300);
    path_0.cubicTo(size.width * 0.5748030, size.height * 0.3632540, size.width * 0.5683830, size.height * 0.3658180,
        size.width * 0.5646380, size.height * 0.3667620);
    path_0.cubicTo(size.width * 0.5606250, size.height * 0.3678410, size.width * 0.5552750, size.height * 0.3682460,
        size.width * 0.5512630, size.height * 0.3677060);
    path_0.cubicTo(size.width * 0.5476510, size.height * 0.3671670, size.width * 0.5400280, size.height * 0.3662220,
        size.width * 0.5345440, size.height * 0.3654130);
    path_0.cubicTo(size.width * 0.5290600, size.height * 0.3646030, size.width * 0.5194300, size.height * 0.3633890,
        size.width * 0.5131430, size.height * 0.3627150);
    path_0.cubicTo(size.width * 0.5068570, size.height * 0.3619050, size.width * 0.4954880, size.height * 0.3605560,
        size.width * 0.4877310, size.height * 0.3597460);
    path_0.cubicTo(size.width * 0.4799730, size.height * 0.3588020, size.width * 0.4695400, size.height * 0.3579920,
        size.width * 0.4643240, size.height * 0.3581270);
    path_0.cubicTo(size.width * 0.4592410, size.height * 0.3581270, size.width * 0.4480060, size.height * 0.3589370,
        size.width * 0.4395800, size.height * 0.3598810);
    path_0.cubicTo(size.width * 0.4299500, size.height * 0.3609610, size.width * 0.4180460, size.height * 0.3613650,
        size.width * 0.4078810, size.height * 0.3608260);
    path_0.cubicTo(size.width * 0.3987860, size.height * 0.3604210, size.width * 0.3862130, size.height * 0.3588020,
        size.width * 0.3797930, size.height * 0.3573180);
    path_0.cubicTo(size.width * 0.3732390, size.height * 0.3558340, size.width * 0.3632080, size.height * 0.3525960,
        size.width * 0.3573230, size.height * 0.3503020);
    path_0.cubicTo(size.width * 0.3514370, size.height * 0.3478740, size.width * 0.3436800, size.height * 0.3442310,
        size.width * 0.3399350, size.height * 0.3420720);
    path_0.cubicTo(size.width * 0.3363240, size.height * 0.3399140, size.width * 0.3305720, size.height * 0.3362710,
        size.width * 0.3272280, size.height * 0.3341120);
    path_0.cubicTo(size.width * 0.3238850, size.height * 0.3318190, size.width * 0.3151910, size.height * 0.3238590,
        size.width * 0.3078340, size.height * 0.3163030);
    path_0.cubicTo(size.width * 0.2988730, size.height * 0.3069940, size.width * 0.2923190, size.height * 0.2987640,
        size.width * 0.2877720, size.height * 0.2910740);
    path_0.cubicTo(size.width * 0.2841600, size.height * 0.2848680, size.width * 0.2793450, size.height * 0.2751540,
        size.width * 0.2770710, size.height * 0.2696220);
    path_0.cubicTo(size.width * 0.2746640, size.height * 0.2640910, size.width * 0.2715880, size.height * 0.2546470,
        size.width * 0.2699830, size.height * 0.2487100);
    path_0.cubicTo(size.width * 0.2685110, size.height * 0.2427740, size.width * 0.2669060, size.height * 0.2350840,
        size.width * 0.2665050, size.height * 0.2314410);
    path_0.cubicTo(size.width * 0.2661040, size.height * 0.2279330, size.width * 0.2650340, size.height * 0.2248300,
        size.width * 0.2643650, size.height * 0.2244250);
    path_0.cubicTo(size.width * 0.2636960, size.height * 0.2240210, size.width * 0.2532640, size.height * 0.2228060,
        size.width * 0.2413600, size.height * 0.2217270);
    path_0.cubicTo(size.width * 0.2293220, size.height * 0.2206480, size.width * 0.2081890, size.height * 0.2197030,
        size.width * 0.1941450, size.height * 0.2197030);
    path_0.cubicTo(size.width * 0.1802350, size.height * 0.2197030, size.width * 0.1569620, size.height * 0.2206480,
        size.width * 0.1426510, size.height * 0.2217270);
    path_0.cubicTo(size.width * 0.1283390, size.height * 0.2228060, size.width * 0.1112190, size.height * 0.2242900,
        size.width * 0.1045320, size.height * 0.2249650);
    path_0.cubicTo(size.width * 0.09797780, size.height * 0.2257740, size.width * 0.08794640, size.height * 0.2269890,
        size.width * 0.08246250, size.height * 0.2276630);
    path_0.cubicTo(size.width * 0.07697870, size.height * 0.2284730, size.width * 0.06868610, size.height * 0.2296870,
        size.width * 0.06413850, size.height * 0.2304960);
    path_0.cubicTo(size.width * 0.05945720, size.height * 0.2311710, size.width * 0.05223460, size.height * 0.2323850,
        size.width * 0.04808830, size.height * 0.2330600);
    path_0.cubicTo(size.width * 0.04380830, size.height * 0.2337340, size.width * 0.03404440, size.height * 0.2356230,
        size.width * 0.02628680, size.height * 0.2372420);
    path_0.cubicTo(size.width * 0.01852920, size.height * 0.2387260, size.width * 0.01077160, size.height * 0.2403450,
        size.width * 0.008899040, size.height * 0.2408850);
    path_0.cubicTo(size.width * 0.006625260, size.height * 0.2414250, size.width * 0.005956500, size.height * 0.2411550,
        size.width * 0.006892760, size.height * 0.2402100);
    path_0.cubicTo(size.width * 0.007695270, size.height * 0.2394010, size.width * 0.01210910, size.height * 0.2365680,
        size.width * 0.01692410, size.height * 0.2340040);
    path_0.cubicTo(size.width * 0.02173920, size.height * 0.2313060, size.width * 0.03524810, size.height * 0.2242900,
        size.width * 0.04701830, size.height * 0.2184890);
    path_0.cubicTo(size.width * 0.05878850, size.height * 0.2126880, size.width * 0.07109360, size.height * 0.2066160,
        size.width * 0.07443740, size.height * 0.2051320);
    path_0.cubicTo(size.width * 0.07778120, size.height * 0.2036480, size.width * 0.08767890, size.height * 0.1994660,
        size.width * 0.09650650, size.height * 0.1956880);
    path_0.cubicTo(size.width * 0.1053340, size.height * 0.1919100, size.width * 0.1165690, size.height * 0.1873230,
        size.width * 0.1216520, size.height * 0.1854340);
    path_0.cubicTo(size.width * 0.1266010, size.height * 0.1835460, size.width * 0.1346260, size.height * 0.1803080,
        size.width * 0.1397080, size.height * 0.1784190);
    path_0.cubicTo(size.width * 0.1446570, size.height * 0.1765300, size.width * 0.1558920, size.height * 0.1724820,
        size.width * 0.1647200, size.height * 0.1695140);
    path_0.cubicTo(size.width * 0.1735480, size.height * 0.1665460, size.width * 0.1846490, size.height * 0.1629030,
        size.width * 0.1894640, size.height * 0.1614190);
    path_0.cubicTo(size.width * 0.1942790, size.height * 0.1599350, size.width * 0.2001640, size.height * 0.1581810,
        size.width * 0.2025720, size.height * 0.1575070);
    path_0.cubicTo(size.width * 0.2048450, size.height * 0.1568320, size.width * 0.2088580, size.height * 0.1557530,
        size.width * 0.2112660, size.height * 0.1550780);
    path_0.cubicTo(size.width * 0.2135390, size.height * 0.1544040, size.width * 0.2203610, size.height * 0.1525150,
        size.width * 0.2262460, size.height * 0.1508960);
    path_0.cubicTo(size.width * 0.2321310, size.height * 0.1492770, size.width * 0.2390860, size.height * 0.1475230,
        size.width * 0.2416270, size.height * 0.1468480);
    path_0.cubicTo(size.width * 0.2441680, size.height * 0.1463090, size.width * 0.2520600, size.height * 0.1444200,
        size.width * 0.2590150, size.height * 0.1428010);
    path_0.cubicTo(size.width * 0.2659700, size.height * 0.1411820, size.width * 0.2743960, size.height * 0.1391580,
        size.width * 0.2777400, size.height * 0.1384840);
    path_0.cubicTo(size.width * 0.2810840, size.height * 0.1378090, size.width * 0.2916500, size.height * 0.1357850,
        size.width * 0.3011470, size.height * 0.1341660);
    path_0.cubicTo(size.width * 0.3107770, size.height * 0.1324120, size.width * 0.3230820, size.height * 0.1302540,
        size.width * 0.3285660, size.height * 0.1294440);
    path_0.cubicTo(size.width * 0.3340500, size.height * 0.1286350, size.width * 0.3428770, size.height * 0.1274200,
        size.width * 0.3479600, size.height * 0.1267460);
    path_0.cubicTo(size.width * 0.3531760, size.height * 0.1259360, size.width * 0.3645450, size.height * 0.1247220,
        size.width * 0.3733730, size.height * 0.1239130);
    path_0.cubicTo(size.width * 0.3822000, size.height * 0.1231030, size.width * 0.3963780, size.height * 0.1218890,
        size.width * 0.4048040, size.height * 0.1213490);
    path_0.cubicTo(size.width * 0.4132310, size.height * 0.1206750, size.width * 0.4326250, size.height * 0.1201350,
        size.width * 0.4480060, size.height * 0.1200000);
    path_0.lineTo(size.width * 0.4480060, size.height * 0.1200000);
    path_0.close();
    path_0.moveTo(size.width * 0.7525590, size.height * 0.1873230);
    path_0.cubicTo(size.width * 0.7546990, size.height * 0.1873230, size.width * 0.7603170, size.height * 0.1888070,
        size.width * 0.7649980, size.height * 0.1904260);
    path_0.cubicTo(size.width * 0.7695460, size.height * 0.1921800, size.width * 0.7811820, size.height * 0.1975770,
        size.width * 0.7906780, size.height * 0.2024340);
    path_0.cubicTo(size.width * 0.8003090, size.height * 0.2072910, size.width * 0.8114100, size.height * 0.2132270,
        size.width * 0.8154230, size.height * 0.2156560);
    path_0.cubicTo(size.width * 0.8194350, size.height * 0.2180840, size.width * 0.8294660, size.height * 0.2244250,
        size.width * 0.8374920, size.height * 0.2299570);
    path_0.cubicTo(size.width * 0.8456500, size.height * 0.2353530, size.width * 0.8547460, size.height * 0.2420990,
        size.width * 0.8576880, size.height * 0.2449330);
    path_0.cubicTo(size.width * 0.8607640, size.height * 0.2477660, size.width * 0.8645090, size.height * 0.2522180,
        size.width * 0.8661140, size.height * 0.2547810);
    path_0.cubicTo(size.width * 0.8679870, size.height * 0.2580190, size.width * 0.8689230, size.height * 0.2617970,
        size.width * 0.8689230, size.height * 0.2669240);
    path_0.cubicTo(size.width * 0.8689230, size.height * 0.2709710, size.width * 0.8681210, size.height * 0.2767730,
        size.width * 0.8671840, size.height * 0.2797410);
    path_0.cubicTo(size.width * 0.8661140, size.height * 0.2827090, size.width * 0.8630380, size.height * 0.2897250,
        size.width * 0.8602290, size.height * 0.2952560);
    path_0.cubicTo(size.width * 0.8575540, size.height * 0.3007880, size.width * 0.8516690, size.height * 0.3107720,
        size.width * 0.8471220, size.height * 0.3175180);
    path_0.cubicTo(size.width * 0.8427080, size.height * 0.3242630, size.width * 0.8352180, size.height * 0.3345170,
        size.width * 0.8304030, size.height * 0.3404530);
    path_0.cubicTo(size.width * 0.8257210, size.height * 0.3463900, size.width * 0.8156900, size.height * 0.3579920,
        size.width * 0.8083340, size.height * 0.3660870);
    path_0.cubicTo(size.width * 0.8008440, size.height * 0.3741820, size.width * 0.7908120, size.height * 0.3848410,
        size.width * 0.7859970, size.height * 0.3896980);
    path_0.cubicTo(size.width * 0.7811820, size.height * 0.3945550, size.width * 0.7744940, size.height * 0.4003560,
        size.width * 0.7712840, size.height * 0.4025150);
    path_0.cubicTo(size.width * 0.7680740, size.height * 0.4046730, size.width * 0.7620560, size.height * 0.4076420,
        size.width * 0.7579090, size.height * 0.4089910);
    path_0.cubicTo(size.width * 0.7538970, size.height * 0.4102050, size.width * 0.7484130, size.height * 0.4112840,
        size.width * 0.7458720, size.height * 0.4112840);
    path_0.cubicTo(size.width * 0.7433300, size.height * 0.4112840, size.width * 0.7366430, size.height * 0.4103400,
        size.width * 0.7311590, size.height * 0.4092610);
    path_0.cubicTo(size.width * 0.7256750, size.height * 0.4081810, size.width * 0.7171150, size.height * 0.4061580,
        size.width * 0.7121660, size.height * 0.4045390);
    path_0.cubicTo(size.width * 0.7070840, size.height * 0.4030540, size.width * 0.6990580, size.height * 0.4006260,
        size.width * 0.6941100, size.height * 0.3990070);
    path_0.cubicTo(size.width * 0.6890270, size.height * 0.3975230, size.width * 0.6808680, size.height * 0.3952290,
        size.width * 0.6756520, size.height * 0.3938800);
    path_0.cubicTo(size.width * 0.6705690, size.height * 0.3925310, size.width * 0.6638820, size.height * 0.3903720,
        size.width * 0.6610730, size.height * 0.3888880);
    path_0.cubicTo(size.width * 0.6581300, size.height * 0.3875390, size.width * 0.6541180, size.height * 0.3848410,
        size.width * 0.6521120, size.height * 0.3829520);
    path_0.cubicTo(size.width * 0.6501050, size.height * 0.3810630, size.width * 0.6480990, size.height * 0.3776900,
        size.width * 0.6475640, size.height * 0.3755320);
    path_0.cubicTo(size.width * 0.6470290, size.height * 0.3731030, size.width * 0.6472960, size.height * 0.3690560,
        size.width * 0.6483670, size.height * 0.3654130);
    path_0.cubicTo(size.width * 0.6493030, size.height * 0.3620400, size.width * 0.6525130, size.height * 0.3556990,
        size.width * 0.6554550, size.height * 0.3512470);
    path_0.cubicTo(size.width * 0.6582640, size.height * 0.3467940, size.width * 0.6642830, size.height * 0.3385640,
        size.width * 0.6688310, size.height * 0.3330330);
    path_0.cubicTo(size.width * 0.6732440, size.height * 0.3275010, size.width * 0.6780590, size.height * 0.3217000,
        size.width * 0.6793970, size.height * 0.3202160);
    path_0.cubicTo(size.width * 0.6807340, size.height * 0.3187320, size.width * 0.6846130, size.height * 0.3138750,
        size.width * 0.6878230, size.height * 0.3094230);
    path_0.cubicTo(size.width * 0.6911670, size.height * 0.3049700, size.width * 0.6945110, size.height * 0.3003830,
        size.width * 0.6954470, size.height * 0.2991690);
    path_0.cubicTo(size.width * 0.6963830, size.height * 0.2980900, size.width * 0.6982560, size.height * 0.2953910,
        size.width * 0.6998610, size.height * 0.2930980);
    path_0.cubicTo(size.width * 0.7014660, size.height * 0.2909390, size.width * 0.7069500, size.height * 0.2806850,
        size.width * 0.7121660, size.height * 0.2702970);
    path_0.cubicTo(size.width * 0.7173820, size.height * 0.2599080, size.width * 0.7235350, size.height * 0.2473610,
        size.width * 0.7258090, size.height * 0.2422340);
    path_0.cubicTo(size.width * 0.7279490, size.height * 0.2372420, size.width * 0.7298210, size.height * 0.2323850,
        size.width * 0.7298210, size.height * 0.2314410);
    path_0.cubicTo(size.width * 0.7298210, size.height * 0.2306310, size.width * 0.7303560, size.height * 0.2291470,
        size.width * 0.7308910, size.height * 0.2284730);
    path_0.cubicTo(size.width * 0.7315600, size.height * 0.2276630, size.width * 0.7334330, size.height * 0.2225360,
        size.width * 0.7350380, size.height * 0.2170050);
    path_0.cubicTo(size.width * 0.7366430, size.height * 0.2114730, size.width * 0.7390500, size.height * 0.2037830,
        size.width * 0.7402540, size.height * 0.2001400);
    path_0.cubicTo(size.width * 0.7413240, size.height * 0.1963630, size.width * 0.7437320, size.height * 0.1920450,
        size.width * 0.7453370, size.height * 0.1902910);
    path_0.cubicTo(size.width * 0.7472090, size.height * 0.1885380, size.width * 0.7500180, size.height * 0.1873230,
        size.width * 0.7525590, size.height * 0.1873230);
    path_0.lineTo(size.width * 0.7525590, size.height * 0.1873230);
    path_0.close();
    path_0.moveTo(size.width * 0.1934770, size.height * 0.2643600);
    path_0.cubicTo(size.width * 0.1945470, size.height * 0.2642260, size.width * 0.1974890, size.height * 0.2646300,
        size.width * 0.2000300, size.height * 0.2651700);
    path_0.cubicTo(size.width * 0.2025720, size.height * 0.2658450, size.width * 0.2060490, size.height * 0.2677330,
        size.width * 0.2077880, size.height * 0.2696220);
    path_0.cubicTo(size.width * 0.2097940, size.height * 0.2716460, size.width * 0.2109980, size.height * 0.2744790,
        size.width * 0.2108640, size.height * 0.2770430);
    path_0.cubicTo(size.width * 0.2108640, size.height * 0.2793360, size.width * 0.2095270, size.height * 0.2824390,
        size.width * 0.2077880, size.height * 0.2841930);
    path_0.cubicTo(size.width * 0.2061830, size.height * 0.2858120, size.width * 0.2044440, size.height * 0.2871610,
        size.width * 0.2039090, size.height * 0.2871610);
    path_0.cubicTo(size.width * 0.2032400, size.height * 0.2871610, size.width * 0.1988270, size.height * 0.2890500,
        size.width * 0.1938780, size.height * 0.2914790);
    path_0.cubicTo(size.width * 0.1887950, size.height * 0.2939070, size.width * 0.1799680, size.height * 0.2986290,
        size.width * 0.1740830, size.height * 0.3020020);
    path_0.cubicTo(size.width * 0.1681970, size.height * 0.3053750, size.width * 0.1585670, size.height * 0.3114460,
        size.width * 0.1526820, size.height * 0.3154940);
    path_0.cubicTo(size.width * 0.1467970, size.height * 0.3194060, size.width * 0.1359630, size.height * 0.3276360,
        size.width * 0.1286070, size.height * 0.3335730);
    path_0.cubicTo(size.width * 0.1212510, size.height * 0.3396440, size.width * 0.1098820, size.height * 0.3498970,
        size.width * 0.1030600, size.height * 0.3566430);
    path_0.cubicTo(size.width * 0.09637270, size.height * 0.3633890, size.width * 0.08620760, size.height * 0.3743170,
        size.width * 0.08032250, size.height * 0.3809280);
    path_0.cubicTo(size.width * 0.07457120, size.height * 0.3876740, size.width * 0.06681360, size.height * 0.3971180,
        size.width * 0.06333600, size.height * 0.4018400);
    path_0.cubicTo(size.width * 0.05985850, size.height * 0.4066970, size.width * 0.05611340, size.height * 0.4115540,
        size.width * 0.05517720, size.height * 0.4126340);
    path_0.cubicTo(size.width * 0.05437470, size.height * 0.4137130, size.width * 0.04929210, size.height * 0.4211330,
        size.width * 0.04394200, size.height * 0.4290930);
    path_0.cubicTo(size.width * 0.03859190, size.height * 0.4371880, size.width * 0.03431190, size.height * 0.4439340,
        size.width * 0.03431190, size.height * 0.4443390);
    path_0.cubicTo(size.width * 0.03431190, size.height * 0.4447440, size.width * 0.03324190, size.height * 0.4466320,
        size.width * 0.03177060, size.height * 0.4486560);
    path_0.cubicTo(size.width * 0.03043310, size.height * 0.4508150, size.width * 0.02775800, size.height * 0.4551320,
        size.width * 0.02575180, size.height * 0.4585050);
    path_0.cubicTo(size.width * 0.02387920, size.height * 0.4618780, size.width * 0.01812790, size.height * 0.4728060,
        size.width * 0.01317910, size.height * 0.4827900);
    path_0.cubicTo(size.width * 0.008230280, size.height * 0.4927740, size.width * 0.003281460, size.height * 0.5031620,
        size.width * 0.002345200, size.height * 0.5057260);
    path_0.cubicTo(size.width * 0.001408940, size.height * 0.5082890, size.width * 0.0003389210,
        size.height * 0.5097730, size.width * 0.00007141780, size.height * 0.5090990);
    path_0.cubicTo(size.width * -0.0003298380, size.height * 0.5084240, size.width * 0.001007680,
        size.height * 0.5014090, size.width * 0.002880210, size.height * 0.4935830);
    path_0.cubicTo(size.width * 0.004886480, size.height * 0.4857580, size.width * 0.006892760, size.height * 0.4775280,
        size.width * 0.007561520, size.height * 0.4753700);
    path_0.cubicTo(size.width * 0.008096530, size.height * 0.4730760, size.width * 0.009969050, size.height * 0.4676790,
        size.width * 0.01157410, size.height * 0.4632270);
    path_0.cubicTo(size.width * 0.01317910, size.height * 0.4587750, size.width * 0.01545290, size.height * 0.4529740,
        size.width * 0.01652290, size.height * 0.4504100);
    path_0.cubicTo(size.width * 0.01759290, size.height * 0.4478470, size.width * 0.02093670, size.height * 0.4405610,
        size.width * 0.02401300, size.height * 0.4342200);
    path_0.cubicTo(size.width * 0.02695550, size.height * 0.4278790, size.width * 0.03284060, size.height * 0.4169510,
        size.width * 0.03698690, size.height * 0.4099350);
    path_0.cubicTo(size.width * 0.04126700, size.height * 0.4029200, size.width * 0.04808830, size.height * 0.3922610,
        size.width * 0.05236840, size.height * 0.3863250);
    path_0.cubicTo(size.width * 0.05651470, size.height * 0.3803890, size.width * 0.06213230, size.height * 0.3728330,
        size.width * 0.06480730, size.height * 0.3694600);
    path_0.cubicTo(size.width * 0.06748230, size.height * 0.3660870, size.width * 0.07149490, size.height * 0.3612300,
        size.width * 0.07376870, size.height * 0.3586670);
    path_0.cubicTo(size.width * 0.07590870, size.height * 0.3561040, size.width * 0.08553880, size.height * 0.3459850,
        size.width * 0.09516900, size.height * 0.3364060);
    path_0.cubicTo(size.width * 0.1046650, size.height * 0.3266920, size.width * 0.1149640, size.height * 0.3167080,
        size.width * 0.1179070, size.height * 0.3141450);
    path_0.cubicTo(size.width * 0.1208490, size.height * 0.3115810, size.width * 0.1251290, size.height * 0.3079380,
        size.width * 0.1274030, size.height * 0.3060500);
    path_0.cubicTo(size.width * 0.1296770, size.height * 0.3041610, size.width * 0.1332880, size.height * 0.3013280,
        size.width * 0.1354280, size.height * 0.2997090);
    path_0.cubicTo(size.width * 0.1375680, size.height * 0.2980900, size.width * 0.1419820, size.height * 0.2947170,
        size.width * 0.1453260, size.height * 0.2922880);
    path_0.cubicTo(size.width * 0.1486700, size.height * 0.2897250, size.width * 0.1558920, size.height * 0.2845980,
        size.width * 0.1613760, size.height * 0.2809550);
    path_0.cubicTo(size.width * 0.1668600, size.height * 0.2771780, size.width * 0.1748850, size.height * 0.2721860,
        size.width * 0.1791650, size.height * 0.2700270);
    path_0.cubicTo(size.width * 0.1834450, size.height * 0.2677330, size.width * 0.1879930, size.height * 0.2655750,
        size.width * 0.1891970, size.height * 0.2651700);
    path_0.cubicTo(size.width * 0.1904000, size.height * 0.2647650, size.width * 0.1924070, size.height * 0.2644950,
        size.width * 0.1934770, size.height * 0.2643600);
    path_0.lineTo(size.width * 0.1934770, size.height * 0.2643600);
    path_0.close();
    path_0.moveTo(size.width * 0.2520600, size.height * 0.2819000);
    path_0.cubicTo(size.width * 0.2536650, size.height * 0.2817650, size.width * 0.2564740, size.height * 0.2825740,
        size.width * 0.2583460, size.height * 0.2833840);
    path_0.cubicTo(size.width * 0.2602190, size.height * 0.2843280, size.width * 0.2626260, size.height * 0.2868920,
        size.width * 0.2635630, size.height * 0.2891850);
    path_0.cubicTo(size.width * 0.2647660, size.height * 0.2916140, size.width * 0.2650340, size.height * 0.2949870,
        size.width * 0.2644990, size.height * 0.2978200);
    path_0.cubicTo(size.width * 0.2640980, size.height * 0.3003830, size.width * 0.2618240, size.height * 0.3042960,
        size.width * 0.2595500, size.height * 0.3065890);
    path_0.cubicTo(size.width * 0.2572760, size.height * 0.3088830, size.width * 0.2497860, size.height * 0.3136050,
        size.width * 0.2428310, size.height * 0.3171130);
    path_0.cubicTo(size.width * 0.2358760, size.height * 0.3206210, size.width * 0.2266470, size.height * 0.3256130,
        size.width * 0.2222330, size.height * 0.3280410);
    path_0.cubicTo(size.width * 0.2178190, size.height * 0.3304700, size.width * 0.2060490, size.height * 0.3380250,
        size.width * 0.1961520, size.height * 0.3447710);
    path_0.cubicTo(size.width * 0.1862540, size.height * 0.3516510, size.width * 0.1735480, size.height * 0.3609610,
        size.width * 0.1680640, size.height * 0.3655480);
    path_0.cubicTo(size.width * 0.1625800, size.height * 0.3702700, size.width * 0.1513450, size.height * 0.3807930,
        size.width * 0.1433200, size.height * 0.3888880);
    path_0.cubicTo(size.width * 0.1351610, size.height * 0.3971180, size.width * 0.1244610, size.height * 0.4089910,
        size.width * 0.1195120, size.height * 0.4153320);
    path_0.cubicTo(size.width * 0.1144290, size.height * 0.4216730, size.width * 0.1096140, size.height * 0.4277440,
        size.width * 0.1088120, size.height * 0.4288240);
    path_0.cubicTo(size.width * 0.1078750, size.height * 0.4299030, size.width * 0.1043980, size.height * 0.4351650,
        size.width * 0.1010540, size.height * 0.4402910);
    path_0.cubicTo(size.width * 0.09771030, size.height * 0.4455530, size.width * 0.09302890, size.height * 0.4527040,
        size.width * 0.09075520, size.height * 0.4564810);
    path_0.cubicTo(size.width * 0.08861510, size.height * 0.4601240, size.width * 0.08393380, size.height * 0.4686240,
        size.width * 0.08072380, size.height * 0.4753700);
    path_0.cubicTo(size.width * 0.07738000, size.height * 0.4821150, size.width * 0.07283240, size.height * 0.4914250,
        size.width * 0.07069240, size.height * 0.4962820);
    path_0.cubicTo(size.width * 0.06855240, size.height * 0.5011390, size.width * 0.06427230, size.height * 0.5123370,
        size.width * 0.06132980, size.height * 0.5212410);
    path_0.cubicTo(size.width * 0.05838720, size.height * 0.5301460, size.width * 0.05477590, size.height * 0.5428280,
        size.width * 0.05317090, size.height * 0.5495740);
    path_0.cubicTo(size.width * 0.05169960, size.height * 0.5563190, size.width * 0.04996080, size.height * 0.5641450,
        size.width * 0.04942580, size.height * 0.5671130);
    path_0.cubicTo(size.width * 0.04835580, size.height * 0.5723750, size.width * 0.04835580, size.height * 0.5722400,
        size.width * 0.04795460, size.height * 0.5637400);
    path_0.cubicTo(size.width * 0.04768710, size.height * 0.5588830, size.width * 0.04822210, size.height * 0.5488990,
        size.width * 0.04902460, size.height * 0.5414790);
    path_0.cubicTo(size.width * 0.04996080, size.height * 0.5340580, size.width * 0.05250210, size.height * 0.5204320,
        size.width * 0.05464220, size.height * 0.5111220);
    path_0.cubicTo(size.width * 0.05678220, size.height * 0.5018130, size.width * 0.06132980, size.height * 0.4872420,
        size.width * 0.06453980, size.height * 0.4787430);
    path_0.cubicTo(size.width * 0.06788360, size.height * 0.4702430, size.width * 0.07390240, size.height * 0.4568860,
        size.width * 0.07804870, size.height * 0.4490610);
    path_0.cubicTo(size.width * 0.08206130, size.height * 0.4412360, size.width * 0.08981890, size.height * 0.4281490,
        size.width * 0.09530270, size.height * 0.4200540);
    path_0.cubicTo(size.width * 0.1006530, size.height * 0.4119590, size.width * 0.1092130, size.height * 0.4000860,
        size.width * 0.1141620, size.height * 0.3937450);
    path_0.cubicTo(size.width * 0.1191110, size.height * 0.3874040, size.width * 0.1322180, size.height * 0.3731030,
        size.width * 0.1433200, size.height * 0.3619050);
    path_0.cubicTo(size.width * 0.1542870, size.height * 0.3507070, size.width * 0.1715410, size.height * 0.3350570,
        size.width * 0.1814390, size.height * 0.3270970);
    path_0.cubicTo(size.width * 0.1913370, size.height * 0.3191370, size.width * 0.2088580, size.height * 0.3063190,
        size.width * 0.2202270, size.height * 0.2987640);
    path_0.cubicTo(size.width * 0.2315960, size.height * 0.2910740, size.width * 0.2428310, size.height * 0.2841930,
        size.width * 0.2449710, size.height * 0.2833840);
    path_0.cubicTo(size.width * 0.2472450, size.height * 0.2825740, size.width * 0.2503210, size.height * 0.2819000,
        size.width * 0.2520600, size.height * 0.2819000);
    path_0.lineTo(size.width * 0.2520600, size.height * 0.2819000);
    path_0.close();
    path_0.moveTo(size.width * 0.9148000, size.height * 0.2979550);
    path_0.cubicTo(size.width * 0.9164050, size.height * 0.2979550, size.width * 0.9192140, size.height * 0.2993040,
        size.width * 0.9210860, size.height * 0.3010580);
    path_0.cubicTo(size.width * 0.9229590, size.height * 0.3026770, size.width * 0.9269720, size.height * 0.3069940,
        size.width * 0.9299140, size.height * 0.3107720);
    path_0.cubicTo(size.width * 0.9329900, size.height * 0.3144140, size.width * 0.9404800, size.height * 0.3250730,
        size.width * 0.9464990, size.height * 0.3343820);
    path_0.cubicTo(size.width * 0.9526520, size.height * 0.3436910, size.width * 0.9610780, size.height * 0.3579920,
        size.width * 0.9652250, size.height * 0.3660870);
    path_0.cubicTo(size.width * 0.9693710, size.height * 0.3741820, size.width * 0.9752560, size.height * 0.3872690,
        size.width * 0.9783320, size.height * 0.3950940);
    path_0.cubicTo(size.width * 0.9812750, size.height * 0.4029200, size.width * 0.9848860, size.height * 0.4131730,
        size.width * 0.9863570, size.height * 0.4180300);
    path_0.cubicTo(size.width * 0.9878290, size.height * 0.4228870, size.width * 0.9901020, size.height * 0.4309820,
        size.width * 0.9913060, size.height * 0.4362440);
    path_0.cubicTo(size.width * 0.9929110, size.height * 0.4425850, size.width * 0.9934460, size.height * 0.4487910,
        size.width * 0.9930450, size.height * 0.4551320);
    path_0.cubicTo(size.width * 0.9925100, size.height * 0.4612030, size.width * 0.9911720, size.height * 0.4670050,
        size.width * 0.9891660, size.height * 0.4713220);
    path_0.cubicTo(size.width * 0.9874270, size.height * 0.4749650, size.width * 0.9830140, size.height * 0.4811710,
        size.width * 0.9792690, size.height * 0.4849490);
    path_0.cubicTo(size.width * 0.9756570, size.height * 0.4888610, size.width * 0.9677660, size.height * 0.4949330,
        size.width * 0.9618810, size.height * 0.4985750);
    path_0.cubicTo(size.width * 0.9559960, size.height * 0.5022180, size.width * 0.9460980, size.height * 0.5076150,
        size.width * 0.9398120, size.height * 0.5107180);
    path_0.cubicTo(size.width * 0.9335250, size.height * 0.5136860, size.width * 0.9248320, size.height * 0.5174640,
        size.width * 0.9204180, size.height * 0.5189480);
    path_0.cubicTo(size.width * 0.9160040, size.height * 0.5204320, size.width * 0.9097180, size.height * 0.5224550,
        size.width * 0.9063740, size.height * 0.5232650);
    path_0.cubicTo(size.width * 0.9012910, size.height * 0.5246140, size.width * 0.8995520, size.height * 0.5244790,
        size.width * 0.8952720, size.height * 0.5223210);
    path_0.cubicTo(size.width * 0.8915270, size.height * 0.5205670, size.width * 0.8865790, size.height * 0.5154400,
        size.width * 0.8777510, size.height * 0.5037020);
    path_0.cubicTo(size.width * 0.8709300, size.height * 0.4947980, size.width * 0.8608980, size.height * 0.4830600,
        size.width * 0.8554140, size.height * 0.4775280);
    path_0.cubicTo(size.width * 0.8499310, size.height * 0.4721320, size.width * 0.8419050, size.height * 0.4649810,
        size.width * 0.8374920, size.height * 0.4616080);
    path_0.cubicTo(size.width * 0.8330780, size.height * 0.4582350, size.width * 0.8255880, size.height * 0.4532430,
        size.width * 0.8207730, size.height * 0.4504100);
    path_0.cubicTo(size.width * 0.8159580, size.height * 0.4477120, size.width * 0.8107410, size.height * 0.4436640,
        size.width * 0.8090020, size.height * 0.4415060);
    path_0.cubicTo(size.width * 0.8073970, size.height * 0.4393470, size.width * 0.8059260, size.height * 0.4359740,
        size.width * 0.8060600, size.height * 0.4338150);
    path_0.cubicTo(size.width * 0.8060600, size.height * 0.4316570, size.width * 0.8075310, size.height * 0.4288240,
        size.width * 0.8098050, size.height * 0.4266650);
    path_0.cubicTo(size.width * 0.8118110, size.height * 0.4247760, size.width * 0.8172950, size.height * 0.4209980,
        size.width * 0.8221100, size.height * 0.4181650);
    path_0.cubicTo(size.width * 0.8269250, size.height * 0.4153320, size.width * 0.8317400, size.height * 0.4120940,
        size.width * 0.8328100, size.height * 0.4111490);
    path_0.cubicTo(size.width * 0.8338800, size.height * 0.4100700, size.width * 0.8377590, size.height * 0.4068320,
        size.width * 0.8415040, size.height * 0.4038640);
    path_0.cubicTo(size.width * 0.8451150, size.height * 0.4008960, size.width * 0.8520710, size.height * 0.3945550,
        size.width * 0.8568860, size.height * 0.3896980);
    path_0.cubicTo(size.width * 0.8617010, size.height * 0.3848410, size.width * 0.8686560, size.height * 0.3772850,
        size.width * 0.8725350, size.height * 0.3728330);
    path_0.cubicTo(size.width * 0.8762800, size.height * 0.3683810, size.width * 0.8831010, size.height * 0.3589370,
        size.width * 0.8877820, size.height * 0.3519210);
    path_0.cubicTo(size.width * 0.8924640, size.height * 0.3449060, size.width * 0.8984820, size.height * 0.3342470,
        size.width * 0.9011570, size.height * 0.3283110);
    path_0.cubicTo(size.width * 0.9038330, size.height * 0.3223750, size.width * 0.9074440, size.height * 0.3130650,
        size.width * 0.9089150, size.height * 0.3076690);
    path_0.cubicTo(size.width * 0.9114560, size.height * 0.2994390, size.width * 0.9122590, size.height * 0.2979550,
        size.width * 0.9148000, size.height * 0.2979550);
    path_0.lineTo(size.width * 0.9148000, size.height * 0.2979550);
    path_0.close();
    path_0.moveTo(size.width * 0.4549610, size.height * 0.4437990);
    path_0.cubicTo(size.width * 0.4660630, size.height * 0.4437990, size.width * 0.4786350, size.height * 0.4443390,
        size.width * 0.4830490, size.height * 0.4451480);
    path_0.cubicTo(size.width * 0.4874630, size.height * 0.4459580, size.width * 0.4970930, size.height * 0.4485210,
        size.width * 0.5044500, size.height * 0.4508150);
    path_0.cubicTo(size.width * 0.5118060, size.height * 0.4531080, size.width * 0.5226400, size.height * 0.4572910,
        size.width * 0.5285250, size.height * 0.4602590);
    path_0.cubicTo(size.width * 0.5344100, size.height * 0.4632270, size.width * 0.5419000, size.height * 0.4675450,
        size.width * 0.5452440, size.height * 0.4697030);
    path_0.cubicTo(size.width * 0.5485880, size.height * 0.4719970, size.width * 0.5560780, size.height * 0.4779330,
        size.width * 0.5619630, size.height * 0.4829250);
    path_0.cubicTo(size.width * 0.5678480, size.height * 0.4879170, size.width * 0.5746690, size.height * 0.4943930,
        size.width * 0.5813570, size.height * 0.5030280);
    path_0.lineTo(size.width * 0.5777460, size.height * 0.5120670);
    path_0.cubicTo(size.width * 0.5757390, size.height * 0.5171940, size.width * 0.5711920, size.height * 0.5273120,
        size.width * 0.5674470, size.height * 0.5347330);
    path_0.cubicTo(size.width * 0.5638350, size.height * 0.5421530, size.width * 0.5578170, size.height * 0.5530810,
        size.width * 0.5542050, size.height * 0.5590180);
    path_0.cubicTo(size.width * 0.5505940, size.height * 0.5649540, size.width * 0.5433710, size.height * 0.5756130,
        size.width * 0.5381550, size.height * 0.5826280);
    path_0.cubicTo(size.width * 0.5328050, size.height * 0.5896440, size.width * 0.5207670, size.height * 0.6034050,
        size.width * 0.5111370, size.height * 0.6131190);
    path_0.cubicTo(size.width * 0.5016410, size.height * 0.6226980, size.width * 0.4916090, size.height * 0.6324120,
        size.width * 0.4890680, size.height * 0.6345710);
    path_0.cubicTo(size.width * 0.4865270, size.height * 0.6367300, size.width * 0.4793040, size.height * 0.6422610,
        size.width * 0.4730180, size.height * 0.6467130);
    path_0.cubicTo(size.width * 0.4667320, size.height * 0.6511660, size.width * 0.4583050, size.height * 0.6571020,
        size.width * 0.4542930, size.height * 0.6598000);
    path_0.cubicTo(size.width * 0.4502800, size.height * 0.6623640, size.width * 0.4445290, size.height * 0.6660060,
        size.width * 0.4415860, size.height * 0.6676250);
    path_0.cubicTo(size.width * 0.4386440, size.height * 0.6692440, size.width * 0.4311540, size.height * 0.6732920,
        size.width * 0.4248670, size.height * 0.6763950);
    path_0.cubicTo(size.width * 0.4185810, size.height * 0.6796330, size.width * 0.4072120, size.height * 0.6847600,
        size.width * 0.3994540, size.height * 0.6878630);
    path_0.cubicTo(size.width * 0.3916970, size.height * 0.6909660, size.width * 0.3830030, size.height * 0.6943390,
        size.width * 0.3800600, size.height * 0.6952830);
    path_0.cubicTo(size.width * 0.3771180, size.height * 0.6963630, size.width * 0.3710990, size.height * 0.6981170,
        size.width * 0.3666850, size.height * 0.6993310);
    path_0.cubicTo(size.width * 0.3622710, size.height * 0.7005450, size.width * 0.3565200, size.height * 0.7021640,
        size.width * 0.3539790, size.height * 0.7028390);
    path_0.cubicTo(size.width * 0.3514370, size.height * 0.7035130, size.width * 0.3459540, size.height * 0.7047270,
        size.width * 0.3419410, size.height * 0.7055370);
    path_0.cubicTo(size.width * 0.3379290, size.height * 0.7062120, size.width * 0.3292350, size.height * 0.7078310,
        size.width * 0.3225470, size.height * 0.7090450);
    path_0.cubicTo(size.width * 0.3133180, size.height * 0.7107990, size.width * 0.3019490, size.height * 0.7113380,
        size.width * 0.2737280, size.height * 0.7113380);
    path_0.cubicTo(size.width * 0.2487160, size.height * 0.7114730, size.width * 0.2338700, size.height * 0.7109340,
        size.width * 0.2275830, size.height * 0.7097190);
    path_0.cubicTo(size.width * 0.2225010, size.height * 0.7087750, size.width * 0.2152780, size.height * 0.7072910,
        size.width * 0.2115330, size.height * 0.7066160);
    path_0.cubicTo(size.width * 0.2079220, size.height * 0.7058070, size.width * 0.2009670, size.height * 0.7043230,
        size.width * 0.1961520, size.height * 0.7031080);
    path_0.cubicTo(size.width * 0.1913370, size.height * 0.7020290, size.width * 0.1829100, size.height * 0.6996010,
        size.width * 0.1774260, size.height * 0.6977120);
    path_0.cubicTo(size.width * 0.1719430, size.height * 0.6959580, size.width * 0.1617770, size.height * 0.6921800,
        size.width * 0.1549560, size.height * 0.6894820);
    path_0.cubicTo(size.width * 0.1482680, size.height * 0.6867840, size.width * 0.1430520, size.height * 0.6840850,
        size.width * 0.1435870, size.height * 0.6835460);
    path_0.cubicTo(size.width * 0.1442560, size.height * 0.6831410, size.width * 0.1513450, size.height * 0.6811170,
        size.width * 0.1593700, size.height * 0.6790930);
    path_0.cubicTo(size.width * 0.1675290, size.height * 0.6770700, size.width * 0.1779610, size.height * 0.6742360,
        size.width * 0.1827760, size.height * 0.6727520);
    path_0.cubicTo(size.width * 0.1875910, size.height * 0.6712680, size.width * 0.1957500, size.height * 0.6685700,
        size.width * 0.2008330, size.height * 0.6669510);
    path_0.cubicTo(size.width * 0.2060490, size.height * 0.6651970, size.width * 0.2128710, size.height * 0.6627680,
        size.width * 0.2162140, size.height * 0.6615540);
    path_0.cubicTo(size.width * 0.2195580, size.height * 0.6602050, size.width * 0.2241060, size.height * 0.6584510,
        size.width * 0.2262460, size.height * 0.6575070);
    path_0.cubicTo(size.width * 0.2285200, size.height * 0.6565620, size.width * 0.2329330, size.height * 0.6546730,
        size.width * 0.2362770, size.height * 0.6533240);
    path_0.cubicTo(size.width * 0.2396210, size.height * 0.6519750, size.width * 0.2465760, size.height * 0.6487370,
        size.width * 0.2516590, size.height * 0.6460390);
    path_0.cubicTo(size.width * 0.2568750, size.height * 0.6433410, size.width * 0.2634290, size.height * 0.6396980,
        size.width * 0.2663710, size.height * 0.6379440);
    path_0.cubicTo(size.width * 0.2693140, size.height * 0.6363250, size.width * 0.2753330, size.height * 0.6324120,
        size.width * 0.2797460, size.height * 0.6294440);
    path_0.cubicTo(size.width * 0.2841600, size.height * 0.6263410, size.width * 0.2928540, size.height * 0.6190560,
        size.width * 0.2990070, size.height * 0.6129840);
    path_0.cubicTo(size.width * 0.3051590, size.height * 0.6070480, size.width * 0.3126490, size.height * 0.5985480,
        size.width * 0.3155920, size.height * 0.5940960);
    path_0.cubicTo(size.width * 0.3185350, size.height * 0.5896440, size.width * 0.3225470, size.height * 0.5826280,
        size.width * 0.3244200, size.height * 0.5785810);
    path_0.cubicTo(size.width * 0.3261580, size.height * 0.5745330, size.width * 0.3284320, size.height * 0.5680570,
        size.width * 0.3295020, size.height * 0.5644140);
    path_0.cubicTo(size.width * 0.3304380, size.height * 0.5606370, size.width * 0.3312410, size.height * 0.5511930,
        size.width * 0.3312410, size.height * 0.5430980);
    path_0.cubicTo(size.width * 0.3312410, size.height * 0.5350030, size.width * 0.3304380, size.height * 0.5255590,
        size.width * 0.3293680, size.height * 0.5215110);
    path_0.cubicTo(size.width * 0.3282980, size.height * 0.5177330, size.width * 0.3261580, size.height * 0.5111220,
        size.width * 0.3245530, size.height * 0.5070750);
    path_0.cubicTo(size.width * 0.3229480, size.height * 0.5030280, size.width * 0.3208080, size.height * 0.4981710,
        size.width * 0.3196050, size.height * 0.4962820);
    path_0.cubicTo(size.width * 0.3180000, size.height * 0.4934480, size.width * 0.3178660, size.height * 0.4926390,
        size.width * 0.3194710, size.height * 0.4912900);
    path_0.cubicTo(size.width * 0.3204070, size.height * 0.4904800, size.width * 0.3262920, size.height * 0.4865680,
        size.width * 0.3325780, size.height * 0.4827900);
    path_0.cubicTo(size.width * 0.3388650, size.height * 0.4788770, size.width * 0.3511700, size.height * 0.4722670,
        size.width * 0.3599980, size.height * 0.4678140);
    path_0.cubicTo(size.width * 0.3688250, size.height * 0.4634970, size.width * 0.3832700, size.height * 0.4575610,
        size.width * 0.3920980, size.height * 0.4547270);
    path_0.cubicTo(size.width * 0.4009260, size.height * 0.4517590, size.width * 0.4114920, size.height * 0.4486560,
        size.width * 0.4155050, size.height * 0.4478470);
    path_0.cubicTo(size.width * 0.4195170, size.height * 0.4470370, size.width * 0.4255360, size.height * 0.4458230,
        size.width * 0.4288800, size.height * 0.4451480);
    path_0.cubicTo(size.width * 0.4322240, size.height * 0.4444740, size.width * 0.4439940, size.height * 0.4439340,
        size.width * 0.4549610, size.height * 0.4437990);
    path_0.lineTo(size.width * 0.4549610, size.height * 0.4437990);
    path_0.close();
    path_0.moveTo(size.width * 0.2951280, size.height * 0.5007340);
    path_0.cubicTo(size.width * 0.2961980, size.height * 0.5008690, size.width * 0.2987390, size.height * 0.5041070,
        size.width * 0.3007460, size.height * 0.5077500);
    path_0.cubicTo(size.width * 0.3026180, size.height * 0.5115270, size.width * 0.3050260, size.height * 0.5184080,
        size.width * 0.3059620, size.height * 0.5232650);
    path_0.cubicTo(size.width * 0.3072990, size.height * 0.5302810, size.width * 0.3072990, size.height * 0.5336540,
        size.width * 0.3058280, size.height * 0.5401300);
    path_0.cubicTo(size.width * 0.3048920, size.height * 0.5445820, size.width * 0.3030190, size.height * 0.5505180,
        size.width * 0.3016820, size.height * 0.5532160);
    path_0.cubicTo(size.width * 0.3002110, size.height * 0.5560500, size.width * 0.2978030, size.height * 0.5592880,
        size.width * 0.2961980, size.height * 0.5603670);
    path_0.cubicTo(size.width * 0.2944590, size.height * 0.5614460, size.width * 0.2917840, size.height * 0.5623910,
        size.width * 0.2901790, size.height * 0.5623910);
    path_0.cubicTo(size.width * 0.2884400, size.height * 0.5623910, size.width * 0.2818870, size.height * 0.5636050,
        size.width * 0.2754660, size.height * 0.5652240);
    path_0.cubicTo(size.width * 0.2689130, size.height * 0.5667080, size.width * 0.2588810, size.height * 0.5698110,
        size.width * 0.2529960, size.height * 0.5722400);
    path_0.cubicTo(size.width * 0.2471110, size.height * 0.5745330, size.width * 0.2393530, size.height * 0.5781760,
        size.width * 0.2356080, size.height * 0.5803350);
    path_0.cubicTo(size.width * 0.2319970, size.height * 0.5824930, size.width * 0.2265130, size.height * 0.5860010,
        size.width * 0.2235710, size.height * 0.5880250);
    path_0.cubicTo(size.width * 0.2206280, size.height * 0.5900490, size.width * 0.2154120, size.height * 0.5945010,
        size.width * 0.2119340, size.height * 0.5980090);
    path_0.cubicTo(size.width * 0.2055140, size.height * 0.6042150, size.width * 0.2055140, size.height * 0.6042150,
        size.width * 0.2055140, size.height * 0.6004370);
    path_0.cubicTo(size.width * 0.2055140, size.height * 0.5984130, size.width * 0.2067180, size.height * 0.5922070,
        size.width * 0.2081890, size.height * 0.5866760);
    path_0.cubicTo(size.width * 0.2096610, size.height * 0.5811440, size.width * 0.2134060, size.height * 0.5719700,
        size.width * 0.2166160, size.height * 0.5664380);
    path_0.cubicTo(size.width * 0.2196920, size.height * 0.5607720, size.width * 0.2255770, size.height * 0.5521370,
        size.width * 0.2295900, size.height * 0.5470100);
    path_0.cubicTo(size.width * 0.2336020, size.height * 0.5420180, size.width * 0.2412260, size.height * 0.5344630,
        size.width * 0.2463090, size.height * 0.5301460);
    path_0.cubicTo(size.width * 0.2515250, size.height * 0.5258280, size.width * 0.2592820, size.height * 0.5198920,
        size.width * 0.2636960, size.height * 0.5169240);
    path_0.cubicTo(size.width * 0.2681100, size.height * 0.5139560, size.width * 0.2765360, size.height * 0.5089640,
        size.width * 0.2824220, size.height * 0.5058610);
    path_0.cubicTo(size.width * 0.2883070, size.height * 0.5027580, size.width * 0.2940580, size.height * 0.5004640,
        size.width * 0.2951280, size.height * 0.5007340);
    path_0.lineTo(size.width * 0.2951280, size.height * 0.5007340);
    path_0.close();
    path_0.moveTo(size.width * 0.9989300, size.height * 0.5084240);
    path_0.cubicTo(size.width * 0.9994650, size.height * 0.5084240, size.width, size.height * 0.5119320, size.width,
        size.height * 0.5161140);
    path_0.cubicTo(size.width, size.height * 0.5204320, size.width * 0.9990640, size.height * 0.5306850,
        size.width * 0.9981280, size.height * 0.5387800);
    path_0.cubicTo(size.width * 0.9970580, size.height * 0.5468750, size.width * 0.9955860, size.height * 0.5565890,
        size.width * 0.9947840, size.height * 0.5603670);
    path_0.cubicTo(size.width * 0.9941150, size.height * 0.5640100, size.width * 0.9923760, size.height * 0.5717000,
        size.width * 0.9909050, size.height * 0.5772320);
    path_0.cubicTo(size.width * 0.9894340, size.height * 0.5827630, size.width * 0.9870260, size.height * 0.5909930,
        size.width * 0.9855550, size.height * 0.5954450);
    path_0.cubicTo(size.width * 0.9840840, size.height * 0.5998970, size.width * 0.9815420, size.height * 0.6069130,
        size.width * 0.9799370, size.height * 0.6109610);
    path_0.cubicTo(size.width * 0.9784660, size.height * 0.6150080, size.width * 0.9743200, size.height * 0.6241820,
        size.width * 0.9708420, size.height * 0.6311980);
    path_0.cubicTo(size.width * 0.9674980, size.height * 0.6382140, size.width * 0.9610780, size.height * 0.6500860,
        size.width * 0.9567980, size.height * 0.6575070);
    path_0.cubicTo(size.width * 0.9523840, size.height * 0.6649270, size.width * 0.9458310, size.height * 0.6751810,
        size.width * 0.9420860, size.height * 0.6804430);
    path_0.cubicTo(size.width * 0.9382070, size.height * 0.6855690, size.width * 0.9321880, size.height * 0.6936640,
        size.width * 0.9284430, size.height * 0.6983860);
    path_0.cubicTo(size.width * 0.9248320, size.height * 0.7029740, size.width * 0.9213540, size.height * 0.7067510,
        size.width * 0.9208190, size.height * 0.7067510);
    path_0.cubicTo(size.width * 0.9201500, size.height * 0.7067510, size.width * 0.9200160, size.height * 0.7060770,
        size.width * 0.9204180, size.height * 0.7054020);
    path_0.cubicTo(size.width * 0.9208190, size.height * 0.7047270, size.width * 0.9220230, size.height * 0.6971720,
        size.width * 0.9230930, size.height * 0.6888070);
    path_0.cubicTo(size.width * 0.9241630, size.height * 0.6805770, size.width * 0.9250990, size.height * 0.6642530,
        size.width * 0.9250990, size.height * 0.6527850);
    path_0.cubicTo(size.width * 0.9250990, size.height * 0.6413170, size.width * 0.9241630, size.height * 0.6255320,
        size.width * 0.9230930, size.height * 0.6177060);
    path_0.cubicTo(size.width * 0.9220230, size.height * 0.6098810, size.width * 0.9205520, size.height * 0.6001670,
        size.width * 0.9198830, size.height * 0.5961200);
    path_0.cubicTo(size.width * 0.9192140, size.height * 0.5920720, size.width * 0.9176090, size.height * 0.5850570,
        size.width * 0.9164050, size.height * 0.5806040);
    path_0.cubicTo(size.width * 0.9153350, size.height * 0.5761520, size.width * 0.9130610, size.height * 0.5688670,
        size.width * 0.9114560, size.height * 0.5644140);
    path_0.cubicTo(size.width * 0.9099850, size.height * 0.5599620, size.width * 0.9090490, size.height * 0.5552400,
        size.width * 0.9095840, size.height * 0.5538910);
    path_0.cubicTo(size.width * 0.9101190, size.height * 0.5521370, size.width * 0.9119910, size.height * 0.5515970,
        size.width * 0.9168060, size.height * 0.5515970);
    path_0.cubicTo(size.width * 0.9202840, size.height * 0.5514620, size.width * 0.9267040, size.height * 0.5506530,
        size.width * 0.9311180, size.height * 0.5497090);
    path_0.cubicTo(size.width * 0.9355320, size.height * 0.5487640, size.width * 0.9424870, size.height * 0.5466050,
        size.width * 0.9464990, size.height * 0.5448520);
    path_0.cubicTo(size.width * 0.9505120, size.height * 0.5432330, size.width * 0.9571990, size.height * 0.5401290,
        size.width * 0.9612120, size.height * 0.5379710);
    path_0.cubicTo(size.width * 0.9652250, size.height * 0.5358120, size.width * 0.9731160, size.height * 0.5304160,
        size.width * 0.9786000, size.height * 0.5260980);
    path_0.cubicTo(size.width * 0.9840840, size.height * 0.5216460, size.width * 0.9906370, size.height * 0.5158450,
        size.width * 0.9931790, size.height * 0.5132810);
    path_0.cubicTo(size.width * 0.9957200, size.height * 0.5105830, size.width * 0.9982610, size.height * 0.5084240,
        size.width * 0.9989300, size.height * 0.5084240);
    path_0.lineTo(size.width * 0.9989300, size.height * 0.5084240);
    path_0.close();
    path_0.moveTo(size.width * 0.9016920, size.height * 0.6198650);
    path_0.lineTo(size.width * 0.9024950, size.height * 0.6237780);
    path_0.cubicTo(size.width * 0.9030300, size.height * 0.6260710, size.width * 0.9034310, size.height * 0.6363250,
        size.width * 0.9035650, size.height * 0.6467130);
    path_0.cubicTo(size.width * 0.9035650, size.height * 0.6571020, size.width * 0.9030300, size.height * 0.6709980,
        size.width * 0.9023610, size.height * 0.6777440);
    path_0.cubicTo(size.width * 0.9015590, size.height * 0.6844900, size.width * 0.9003550, size.height * 0.6940690,
        size.width * 0.8995520, size.height * 0.6993310);
    path_0.cubicTo(size.width * 0.8987500, size.height * 0.7045930, size.width * 0.8972790, size.height * 0.7129570,
        size.width * 0.8962090, size.height * 0.7182190);
    path_0.cubicTo(size.width * 0.8952720, size.height * 0.7234810, size.width * 0.8931320, size.height * 0.7325200,
        size.width * 0.8915270, size.height * 0.7384570);
    path_0.cubicTo(size.width * 0.8900560, size.height * 0.7443930, size.width * 0.8871130, size.height * 0.7541070,
        size.width * 0.8849730, size.height * 0.7600430);
    path_0.cubicTo(size.width * 0.8829670, size.height * 0.7659790, size.width * 0.8800250, size.height * 0.7738050,
        size.width * 0.8785530, size.height * 0.7775820);
    path_0.cubicTo(size.width * 0.8770820, size.height * 0.7812250, size.width * 0.8740060, size.height * 0.7882410,
        size.width * 0.8715980, size.height * 0.7930980);
    path_0.cubicTo(size.width * 0.8691910, size.height * 0.7979550, size.width * 0.8650440, size.height * 0.8055100,
        size.width * 0.8625030, size.height * 0.8099620);
    path_0.cubicTo(size.width * 0.8598280, size.height * 0.8144140, size.width * 0.8539430, size.height * 0.8229140,
        size.width * 0.8493960, size.height * 0.8288510);
    path_0.cubicTo(size.width * 0.8448480, size.height * 0.8347870, size.width * 0.8388290, size.height * 0.8418020,
        size.width * 0.8360200, size.height * 0.8445010);
    path_0.cubicTo(size.width * 0.8330780, size.height * 0.8471990, size.width * 0.8271930, size.height * 0.8520560,
        size.width * 0.8227790, size.height * 0.8554290);
    path_0.cubicTo(size.width * 0.8183650, size.height * 0.8588020, size.width * 0.8126140, size.height * 0.8627150,
        size.width * 0.8100720, size.height * 0.8639290);
    path_0.cubicTo(size.width * 0.8075310, size.height * 0.8652780, size.width * 0.8027160, size.height * 0.8671670,
        size.width * 0.7993720, size.height * 0.8681110);
    path_0.cubicTo(size.width * 0.7960290, size.height * 0.8691900, size.width * 0.7909460, size.height * 0.8700000,
        size.width * 0.7880030, size.height * 0.8700000);
    path_0.cubicTo(size.width * 0.7850610, size.height * 0.8700000, size.width * 0.7805130, size.height * 0.8693250,
        size.width * 0.7779720, size.height * 0.8685160);
    path_0.cubicTo(size.width * 0.7754310, size.height * 0.8677060, size.width * 0.7706160, size.height * 0.8658180,
        size.width * 0.7672720, size.height * 0.8641990);
    path_0.cubicTo(size.width * 0.7639280, size.height * 0.8625800, size.width * 0.7580430, size.height * 0.8578580,
        size.width * 0.7540300, size.height * 0.8538100);
    path_0.cubicTo(size.width * 0.7492150, size.height * 0.8489530, size.width * 0.7450690, size.height * 0.8428820,
        size.width * 0.7419930, size.height * 0.8362710);
    path_0.cubicTo(size.width * 0.7378470, size.height * 0.8270970, size.width * 0.7373120, size.height * 0.8249380,
        size.width * 0.7373120, size.height * 0.8140100);
    path_0.cubicTo(size.width * 0.7373120, size.height * 0.8052400, size.width * 0.7378460, size.height * 0.8007880,
        size.width * 0.7394520, size.height * 0.7978200);
    path_0.cubicTo(size.width * 0.7406550, size.height * 0.7956610, size.width * 0.7433300, size.height * 0.7921530,
        size.width * 0.7454700, size.height * 0.7902640);
    path_0.cubicTo(size.width * 0.7474770, size.height * 0.7882410, size.width * 0.7530940, size.height * 0.7847330,
        size.width * 0.7579090, size.height * 0.7821690);
    path_0.cubicTo(size.width * 0.7627240, size.height * 0.7797410, size.width * 0.7702140, size.height * 0.7752890,
        size.width * 0.7746280, size.height * 0.7723210);
    path_0.cubicTo(size.width * 0.7790420, size.height * 0.7693520, size.width * 0.7858630, size.height * 0.7642260,
        size.width * 0.7897420, size.height * 0.7608530);
    path_0.cubicTo(size.width * 0.7936210, size.height * 0.7574800, size.width * 0.8004420, size.height * 0.7499240,
        size.width * 0.8048560, size.height * 0.7441230);
    path_0.cubicTo(size.width * 0.8091360, size.height * 0.7384570, size.width * 0.8126140, size.height * 0.7334650,
        size.width * 0.8124800, size.height * 0.7331950);
    path_0.cubicTo(size.width * 0.8122120, size.height * 0.7327900, size.width * 0.8075310, size.height * 0.7341390,
        size.width * 0.8020470, size.height * 0.7360280);
    path_0.cubicTo(size.width * 0.7965640, size.height * 0.7379170, size.width * 0.7890730, size.height * 0.7402100,
        size.width * 0.7853280, size.height * 0.7411550);
    path_0.cubicTo(size.width * 0.7817170, size.height * 0.7420990, size.width * 0.7738260, size.height * 0.7437180,
        size.width * 0.7679410, size.height * 0.7446630);
    path_0.cubicTo(size.width * 0.7620560, size.height * 0.7454720, size.width * 0.7538970, size.height * 0.7458770,
        size.width * 0.7498840, size.height * 0.7454720);
    path_0.cubicTo(size.width * 0.7458720, size.height * 0.7450670, size.width * 0.7395850, size.height * 0.7437180,
        size.width * 0.7358400, size.height * 0.7425040);
    path_0.cubicTo(size.width * 0.7312930, size.height * 0.7411550, size.width * 0.7260760, size.height * 0.7376470,
        size.width * 0.7199240, size.height * 0.7319810);
    path_0.cubicTo(size.width * 0.7148410, size.height * 0.7273930, size.width * 0.7084210, size.height * 0.7202430,
        size.width * 0.7057460, size.height * 0.7161950);
    path_0.cubicTo(size.width * 0.7030710, size.height * 0.7121480, size.width * 0.6997270, size.height * 0.7063460,
        size.width * 0.6983900, size.height * 0.7033780);
    path_0.cubicTo(size.width * 0.6969180, size.height * 0.7002750, size.width * 0.6955810, size.height * 0.6940690,
        size.width * 0.6953130, size.height * 0.6885370);
    path_0.cubicTo(size.width * 0.6949120, size.height * 0.6803080, size.width * 0.6951800, size.height * 0.6784190,
        size.width * 0.6979880, size.height * 0.6743710);
    path_0.cubicTo(size.width * 0.6995930, size.height * 0.6718080, size.width * 0.7040070, size.height * 0.6678950,
        size.width * 0.7143060, size.height * 0.6615540);
    path_0.lineTo(size.width * 0.7597820, size.height * 0.6619590);
    path_0.cubicTo(size.width * 0.7872010, size.height * 0.6622290, size.width * 0.8107410, size.height * 0.6618240,
        size.width * 0.8187660, size.height * 0.6608800);
    path_0.cubicTo(size.width * 0.8261230, size.height * 0.6600700, size.width * 0.8352180, size.height * 0.6587210,
        size.width * 0.8388290, size.height * 0.6580460);
    path_0.cubicTo(size.width * 0.8425740, size.height * 0.6572370, size.width * 0.8491280, size.height * 0.6553480,
        size.width * 0.8535420, size.height * 0.6537290);
    path_0.cubicTo(size.width * 0.8579560, size.height * 0.6522450, size.width * 0.8649110, size.height * 0.6492770,
        size.width * 0.8689230, size.height * 0.6471180);
    path_0.cubicTo(size.width * 0.8729360, size.height * 0.6449600, size.width * 0.8793560, size.height * 0.6407770,
        size.width * 0.8829670, size.height * 0.6379440);
    path_0.cubicTo(size.width * 0.8867120, size.height * 0.6351110, size.width * 0.8923300, size.height * 0.6298490,
        size.width * 0.8956740, size.height * 0.6263410);
    path_0.lineTo(size.width * 0.9016920, size.height * 0.6198650);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0xffF22222);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

import 'package:flutter/material.dart';

import 'package:champmastery/di/di.dart';
import 'package:champmastery/presentation/core/theme.dart';
import 'package:champmastery/presentation/home/home_page.dart';

void main() async {
  await initDi();

  runApp(
    MaterialApp(
      locale: const Locale('ru'),
      theme: mainTheme(),
      home: const HomePage(),
    ),
  );
}

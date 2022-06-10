import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:champmastery/data/utils/disable_certificate_check_http.dart';
import 'package:champmastery/di/di.dart';
import 'package:champmastery/presentation/core/theme.dart';
import 'package:champmastery/presentation/home/home_page.dart';

void main() async {
  await initDi();

  HttpOverrides.global = DisableCertificateCheckHttpOverrides();

  runApp(
    MaterialApp(
      theme: mainTheme(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomePage(),
    ),
  );
}

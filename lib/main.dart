import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:sebastian/data/utils/disable_certificate_check_http.dart';
import 'package:sebastian/di/di.dart';
import 'package:sebastian/presentation/core/theme.dart';
import 'package:sebastian/presentation/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

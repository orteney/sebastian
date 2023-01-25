import 'dart:io';

import 'package:flutter/material.dart';

import 'package:sebastian/data/utils/disable_certificate_check_http.dart';
import 'package:sebastian/di/di.dart';
import 'package:sebastian/presentation/sebastian_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDi();

  HttpOverrides.global = DisableCertificateCheckHttpOverrides();

  runApp(const SebastianApp());
}

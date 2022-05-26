import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersion extends StatefulWidget {
  const AppVersion({super.key});

  @override
  State<AppVersion> createState() => _AppVersionState();
}

class _AppVersionState extends State<AppVersion> {
  PackageInfo? packageInfo;

  Future<void> loadPackageInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
    setState(() {});
  }

  @override
  void initState() {
    loadPackageInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (packageInfo == null) {
      return const SizedBox.shrink();
    } else {
      return Text('Версия: ${packageInfo!.version}');
    }
  }
}

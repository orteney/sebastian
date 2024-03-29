import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersion extends StatefulWidget {
  const AppVersion({super.key});

  @override
  State<AppVersion> createState() => _AppVersionState();
}

class _AppVersionState extends State<AppVersion> {
  PackageInfo? packageInfo;

  Future<void> _loadPackageInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
    setState(() {});
  }

  @override
  void initState() {
    _loadPackageInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Stack(
      children: [
        Image.asset('assets/images/app_logo_version.png'),
        if (packageInfo != null)
          Positioned(
            right: 0,
            bottom: 0,
            child: Text(
              appLocalizations.appVersion(packageInfo!.version),
              style: theme.textTheme.bodySmall,
            ),
          ),
      ],
    );
  }
}

// a placeholder screen for future development,

import 'package:flutter/material.dart';
import 'package:tinyforests/widgets/builderitems.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForestGuide extends StatefulWidget {
  const ForestGuide({super.key});

  @override
  State<ForestGuide> createState() => _ForestGuideState();
}

class _ForestGuideState extends State<ForestGuide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.guideTitle,
        ),
      ),
      body: Center(
        child: Text(
          AppLocalizations.of(context)!.guideSubTitle,
        ),
      ),
      bottomNavigationBar: bottomNaviBar(context),
    );
  }
}

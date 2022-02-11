import 'dart:io';

import 'package:flutter/material.dart';

abstract class PlatformAwareWidget extends StatelessWidget {
  const PlatformAwareWidget({Key? key}) : super(key: key);

  Widget buildMaterialWidget(BuildContext context);
  Widget buildCupertinoWidgt(BuildContext context);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return buildCupertinoWidgt(context);
    } else {
      return buildMaterialWidget(context);
    }
  }
}

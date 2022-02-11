import 'package:flutter/material.dart';
import 'package:movity/src/presentaion/screens/07_settings_screen/widgets/general_section.dart';
import 'package:movity/src/presentaion/screens/07_settings_screen/widgets/notification_section.dart';
import 'package:movity/src/presentaion/screens/07_settings_screen/widgets/theme_section.dart';

class SettingsDetails extends StatefulWidget {
  const SettingsDetails({Key? key}) : super(key: key);

  @override
  State<SettingsDetails> createState() => _SettingsDetailsState();
}

class _SettingsDetailsState extends State<SettingsDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const NotificationSection(),
        ThemeSection(),
        const GeneralSection(),
      ],
    );
  }
}

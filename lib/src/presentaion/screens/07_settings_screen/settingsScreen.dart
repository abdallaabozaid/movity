import 'package:flutter/material.dart';
import 'package:movity/src/presentaion/screens/00_common_widgets/scaffold_appbar.dart';
import 'package:movity/src/presentaion/screens/07_settings_screen/widgets/body.dart';
import 'package:movity/src/presentaion/screens/07_settings_screen/widgets/settings_scaffold_appbar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  static String routeName = '/settingsScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,

      appBar: PreferredSize(
        child: const SettingsScaffoldAppBar(titleText: 'Settings'),
        preferredSize: Size(MediaQuery.of(context).size.width, 90),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                children: const [SettingsDetails()],
              ),
            )
          ],
        ),
      ),
    );
  }
}
